import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loc/core/server/shered_pref_helper.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:loc/featuers/week_time_line/presentation/views/time_line_view.dart';
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
     if (FirebaseAuth.instance.currentUser != null) {
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
        : Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              width: double.infinity,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(kLogo)),
               Card_Button(
                page: const TimeLineVeiw(), text: S.of(context).time_line,icon: Icons.calendar_month,),

             Card_Button(
              page: const BookLocView(), text: S.of(context).add_event,icon: Icons.add,),
            Visibility(
                visible: isAdmin,
                child:  Card_Button(
                  color: Colors.red,
                    page: const BottomNavBar(),
                    icon: Icons.admin_panel_settings_rounded,
                    text: S.of(context).admin_panel)),
          ],
        );
  }
}
