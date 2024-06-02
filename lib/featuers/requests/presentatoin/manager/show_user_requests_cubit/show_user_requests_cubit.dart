import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loc/featuers/requests/data/models/request_model.dart';
import 'show_user_requests_state.dart';

class ShowUserRequestsCubit extends Cubit<ShowUserRequestsState> {
  ShowUserRequestsCubit() : super(ShowUserRequestsState());

  final String id = FirebaseAuth.instance.currentUser!.uid;

  Future<void> fetchRequests() async {
    try {
      emit(UserRequestsLoading());
      Query query = FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .collection('requests')
          .orderBy('startTime', descending: true);

      query.snapshots().listen(
        (snapshot) {
          List<UserRequestModel> requests = snapshot.docs
              .map((doc) {
                try {
                  return UserRequestModel.fromDocumentSnapshot(doc);
                } catch (e) {
                  print('Error creating UserRequestModel from document: $e');
                  return null;
                }
              })
              .where((request) => request != null) // Filter out null values
              .cast<UserRequestModel>() // Cast back to the correct type
              .toList();
          if (!isClosed) {
            emit(UserRequestsLoaded(requests));
          }
        },
        onError: (error) {
          print('Error fetching snapshots: $error');
          if (!isClosed) {
            emit(UserRequestsError('Failed to fetch requests'));
          }
        },
      );
    } catch (e) {
      if (!isClosed) {
        emit(UserRequestsError('Failed to fetch requests'));
      }
    }
  }
}
