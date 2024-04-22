import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/Custom_TextField.dart';
import '../../../../generated/l10n.dart';

class AdminViewBody extends StatefulWidget {
  const AdminViewBody({super.key});

  @override
  State<AdminViewBody> createState() => _AdminViewBodyState();
}

class _AdminViewBodyState extends State<AdminViewBody> {
  late TextEditingController location;
  late TextEditingController floor;
  GlobalKey<FormState> key = GlobalKey();
  CollectionReference loc = FirebaseFirestore.instance.collection('loc');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    location = TextEditingController();
    floor = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    location.dispose();
    floor.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomTextField(
                    onSaved: (value) {
                      location.text = value!;
                    },
                    hinttext: S.of(context).name_loc,
                    textEditingController: location,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: CustomTextField(
                    onSaved: (value) {
                      floor.text = value!;
                    },
                    hinttext: S.of(context).floor,
                    textEditingController: floor,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
              onPressed: () {
                if (key.currentState!.validate()) {
                  addloc();
                  location.clear();
                  floor.clear();
                } else {
                  print('error');
                }
              },
              child: Text(S.of(context).add_loc)),
          //  const HallsListView()
        ],
      ),
    );
  }

  Future<void> addloc() {
    return loc
        .add({'name_loc': location.text, 'floor': floor.text})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}


    