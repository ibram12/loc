import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/featuers/requests/presentatoin/widgets/request_item.dart';
import '../../../../core/helper/snack_bar.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/user_request_model.dart';
import '../manager/show_user_requests_cubit/show_user_requests_cubit.dart';
import 'request_to_accept_the_modification_form_admin.dart';

class UserRequestBody extends StatefulWidget {
  const UserRequestBody({
    super.key,
  });

  @override
  State<UserRequestBody> createState() => _UserRequestBodyState();
}

class _UserRequestBodyState extends State<UserRequestBody> {
  late Query query;
  late Stream<QuerySnapshot> stream;
  final String id = FirebaseAuth.instance.currentUser!.uid;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ShowUserRequestsCubit>(context).checkAndDeleteRequests();
    query = FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('requests')
        .orderBy('startTime', descending: true);

    stream = query.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(S.of(context).no_requests_yet),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(S.of(context).failed_to_fetch_requests));
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return snapshot.data!.docs[index]['adminModified'] == true
                  ? RequestToAcceptTheModificationFormAdminItem(
                      requestModel: UserRequestModel.fromDocumentSnapshot(
                        snapshot.data!.docs[index],
                      ),
                    )
                  : UserRequestItem(
                      onRequestDeleted: () async {
                        showSnackBar(context,
                            S.of(context).your_request_deleted_successfully);
                      },
                      requestModel: UserRequestModel.fromDocumentSnapshot(
                          snapshot.data!.docs[index]),
                    );
            },
          );
        });
  }
}
