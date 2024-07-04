import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/core/text_styles/Styles.dart';
import 'package:loc/featuers/messages/presentation/manager/reed_messages_cubit/reed_messages_cubit.dart';
import 'package:loc/featuers/messages/presentation/views/widgets/cusotm_chat_text_field.dart';
import 'package:loc/featuers/messages/presentation/views/widgets/custom_chat_buble.dart';
import '../../../../../generated/l10n.dart';
import '../../../data/models/chat_buble_model.dart';
import 'custom_chat_buble_for_friend.dart';

class MessagesViewBody extends StatefulWidget {
  const MessagesViewBody({super.key});

  @override
  State<MessagesViewBody> createState() => _MessagesViewBodyState();
}

class _MessagesViewBodyState extends State<MessagesViewBody> {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late ScrollController controller;
  late Query query;
  late Stream<QuerySnapshot> stream;
  @override
  void initState() {
    super.initState();
    context.read<DeleteOldMessagesCubit>().featchOldMessges();
    query = FirebaseFirestore.instance.collection('messages').orderBy('time');
    stream = query.snapshots();
    controller = ScrollController();
  }

@override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return const Center(child: Text('Error fetching messages.'));
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text(
                    S.of(context).there_was_no_messages_yet,
                    style: Styles.textStyle20,
                  ),
                );
              }
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (controller.hasClients) {
                  controller.animateTo(
                    controller.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                }
              });
              return ListView.builder(
                controller: controller,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return snapshot.data!.docs[index]['id'] == userId
                      ? ChatBuble(
                          index: index,
                          bubleModel: ChatBubleModel.fromJson(
                              snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>,
                              snapshot.data!.docs[index].id),
                        )
                      : ChatBubleForFriend(
                          bubleModel: ChatBubleModel.fromJson(
                              snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>,
                              snapshot.data!.docs[index].id),
                        );
                },
              );
            },
          ),
        ),
        CusotmChatTextField(
          formKey: formKey,
          onSent: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (controller.hasClients) {
                controller.animateTo(
                  controller.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              }
            });
          },
        ),
        SizedBox(
          height: MediaQuery.of(context).viewInsets.bottom,
        )
      ],
    );
  }
}
