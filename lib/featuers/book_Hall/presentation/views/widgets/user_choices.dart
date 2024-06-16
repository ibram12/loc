import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/core/server/shered_pref_helper.dart';
import 'package:loc/core/text_styles/Styles.dart';
import 'package:loc/core/widgets/Custom_TextField.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/cubits/select_time_cubit/select_time_cubit.dart';

class UserChoices extends StatefulWidget {
  const UserChoices({
    super.key,
    required this.onServiceSelected,
  });
  final void Function(String?) onServiceSelected;

  @override
  State<UserChoices> createState() => _UserChoicesState();
}

class _UserChoicesState extends State<UserChoices> {
  TextEditingController controller = TextEditingController();
  Future<List> _fetchTexts() async {
    String userid = FirebaseAuth.instance.currentUser!.uid;
    final snapshot =
        await FirebaseFirestore.instance.collection('users').doc(userid).get();
    return snapshot.data()?['service'] as List;
  }

  String? isAdmin;
  Future<void> _checkRole() async {
    isAdmin = await SherdPrefHelper().getUserRole();
  }

  String? _selectedText;

  late SelectTimeCubit selectTimeCubit;
  @override
  void initState() {
    _checkRole();
    selectTimeCubit = BlocProvider.of<SelectTimeCubit>(context);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: kOrange),
          onPressed: () => selectTimeCubit.selectDate(context),
          child: Text(
            S.of(context).make_reservation,
            style: Styles.textStyle18.copyWith(color: Colors.black),
          )),
      FutureBuilder(
        future: _fetchTexts(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } else {
            final servises = snapshot.data;
            if (servises?.length == 1) {
              _selectedText = servises![0];
              widget.onServiceSelected(_selectedText);
              return const SizedBox();
            }
            return Column(
              children: [
                DropdownButton<String>(
                  hint: Text(
                    S.of(context).service,
                  ),
                    iconEnabledColor: kPrimaryColor,
                    value: _selectedText,
                    items: servises!.map((service) {
                      return DropdownMenuItem<String>(
                        
                        value: service,
                        child: Text(
                          service,
                          style:
                              const TextStyle(overflow: TextOverflow.ellipsis),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newHallName) {
                      if (newHallName != null) {
                        setState(() {
                           _selectedText = newHallName;
                          widget.onServiceSelected(_selectedText);
                        });
                      } else {}
                    },
                  ),
                isAdmin != kRoles[2]
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: CustomTextField(
                              onChanged: (service) {
                                if (controller.text == '') {
                                  widget.onServiceSelected(_selectedText);
                                } else {
                                  widget.onServiceSelected(controller.text);
                                }
                              },
                              hinttext: S.of(context).new_service,
                              textEditingController: controller),
                        ),
                      ),
              ],
            );
          }
        },
      ),
    ]);
  }
}
