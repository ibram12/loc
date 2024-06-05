import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loc/core/text_styles/Styles.dart';
import 'package:loc/featuers/admin/data/models/user_info_model.dart';
import 'package:loc/featuers/admin/pressntation/widgets/user_info_card.dart';

class AllUsersViewBody extends StatefulWidget {
  const AllUsersViewBody({super.key});

  @override
  State<AllUsersViewBody> createState() => _AllUsersViewBodyState();
}

class _AllUsersViewBodyState extends State<AllUsersViewBody> {
  Query query = FirebaseFirestore.instance.collection('users');
  late Stream<QuerySnapshot> stream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stream = query.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data == null) {
            return const Center(child: Text('No Users yet',style: Styles.textStyle18,));
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return  UserInfoCard(
                  userInfoModel: UserInfoModel.fromDocumentSnapshot(
                    snapshot.data!.docs[index],
                  ),
                );
              });
        });
  }
}
