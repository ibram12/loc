import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/core/text_styles/Styles.dart';
import '../../../../../core/utils/constants.dart';
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
  Future<List> _fetchTexts() async {
    String userid = FirebaseAuth.instance.currentUser!.uid;
    final snapshot =
        await FirebaseFirestore.instance.collection('users').doc(userid).get();
    return snapshot.data()?['service'] as List;
  }

  String? _selectedText;

  late SelectTimeCubit selectTimeCubit;
  @override
  void initState() {
    selectTimeCubit = BlocProvider.of<SelectTimeCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: kOrange),
          onPressed: () => selectTimeCubit.selectDate(context),
          child: Text(
            'Make Reservation',
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
                ...?servises?.map((text) => RadioListTile<String>(
                      //... used to genrate widgets insted of the list count
                      title: Text(text),
                      activeColor: kOrange,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 40),
                      value: text,
                      groupValue: _selectedText,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedText = value;
                        });
                        widget.onServiceSelected(_selectedText);
                      },
                    ))
              ],
            );
          }
        },
      ),
      
    ]);
  }
}
