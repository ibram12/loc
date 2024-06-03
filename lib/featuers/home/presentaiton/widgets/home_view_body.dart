import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loc/core/server/shered_pref_helper.dart';
import 'package:loc/core/utils/constants.dart';

import '../../../../generated/l10n.dart';
import '../../../admin/pressntation/view/bottomNav_bar.dart';
import '../../../book_Hall/presentation/views/book_loc_view.dart';
import 'Card_Button.dart';

class HomeVeiwBody extends StatefulWidget {
  const HomeVeiwBody({super.key});

  @override
  State<HomeVeiwBody> createState() => _HomeVeiwBodyState();
}

class _HomeVeiwBodyState extends State<HomeVeiwBody> {
  bool isAdmin = false;
  bool isLoading = true;

  void checkRole() async {
    bool? savedRole = await SherdPrefHelper().getUserRole();
    if (savedRole != null) {
      setState(() {
        isAdmin = savedRole;
        isLoading = false;
      });
    } else {
      String id = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot userInfo =
          await FirebaseFirestore.instance.collection('users').doc(id).get();
      if (userInfo['role'] == 'Admin') {
        setState(() {
          isAdmin = true;
          isLoading = false;
        });
        await SherdPrefHelper().setUserRole(true);
      } else {
        setState(() {
          isAdmin = false;
          isLoading = false;
        });
        await SherdPrefHelper().setUserRole(false);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    checkRole();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  width: double.infinity,
                ),
                Image.asset(kLogo),
                const SizedBox(
                  height: 79,
                ),
                const Card_Button(page: BookLocView(), text: 'Add Event'),
                Visibility(
                    visible: isAdmin,
                    child: Card_Button(
                        page: const BottomNavBar(),
                        text: S.of(context).add_khdma)),
              ],
            ),
          );
  }
}
