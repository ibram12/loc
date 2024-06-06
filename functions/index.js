const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.scheduledFunction = functions.pubsub.schedule('every saturday 00:00').onRun(async (context) => {
  const now = new Date();
  const startOfWeek = new Date(now);
  startOfWeek.setDate(now.getDate() - now.getDay() + 6); // Saturday
  startOfWeek.setHours(0, 0, 0, 0);

  const endOfWeek = new Date(startOfWeek);
  endOfWeek.setDate(startOfWeek.getDate() + 6); // Friday
  endOfWeek.setHours(23, 59, 59, 999);

  const db = admin.firestore();
  const deletionDateRef = db.collection('admin').doc('deletionDate');
  const deletionDateSnapshot = await deletionDateRef.get();
  let lastDeletionDate = new Date(0);

  if (deletionDateSnapshot.exists) {
    lastDeletionDate = deletionDateSnapshot.get('date').toDate();
  }

  if (!isSameDay(now, lastDeletionDate)) {
    const usersSnapshot = await db.collection('users').get();
    const batch = db.batch();

    // Deleting from requests subcollection
    for (const userDoc of usersSnapshot.docs) {
      const requestsQuery = userDoc.ref.collection('requests');
      const requestsSnapshot = await requestsQuery.get();

      requestsSnapshot.forEach(requestDoc => {
        const daily = requestDoc.get('daily');
        if (daily === false) {
          batch.delete(requestDoc.ref);
        }
      });
    }

    // Deleting from reservations subcollection
    const locsSnapshot = await db.collection('locs').get();
    for (const locDoc of locsSnapshot.docs) {
      const reservationsQuery = locDoc.ref.collection('reservations');
      const reservationsSnapshot = await reservationsQuery.get();

      reservationsSnapshot.forEach(reservationDoc => {
        batch.delete(reservationDoc.ref);
      });
    }

    await batch.commit();
    await deletionDateRef.set({ date: admin.firestore.Timestamp.fromDate(now) });
    console.log('Deleted documents from the requests and reservations subcollections.');
  }
  return null;
});

function isSameDay(date1, date2) {
  return date1.getFullYear() === date2.getFullYear() &&
         date1.getMonth() === date2.getMonth() &&
         date1.getDate() === date2.getDate();
}
