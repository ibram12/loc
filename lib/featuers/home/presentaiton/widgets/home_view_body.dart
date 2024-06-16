import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/core/server/shered_pref_helper.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:loc/featuers/week_time_line/presentation/views/time_line_view.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../../generated/l10n.dart';
import '../../../admin/pressntation/view/bottomNav_bar.dart';
import '../../../book_Hall/presentation/views/book_loc_view.dart';
import '../manager/delete_old_data_cubit/delete_old_data_cubit.dart';
import 'Card_Button.dart';

class HomeVeiwBody extends StatefulWidget {
  const HomeVeiwBody({super.key});

  @override
  State<HomeVeiwBody> createState() => _HomeVeiwBodyState();
}

class _HomeVeiwBodyState extends State<HomeVeiwBody> {
  String? userRole;
  bool isLoading = true;
  void checkRole() async {
     if (await SherdPrefHelper().getUserRole() == null) {
      String id = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot userInfo =
          await FirebaseFirestore.instance.collection('users').doc(id).get();
      if (userInfo['role'] == kRoles[2]) {
        setState(() {
          userRole = kRoles[2];
          isLoading = false;
        });
        await SherdPrefHelper().setUserRole(kRoles[2]);
      }else if (userInfo['role'] == kRoles[1])  {
        setState(() {
          userRole = kRoles[1];
          isLoading = false;
        });
        await SherdPrefHelper().setUserRole(kRoles[1]);
      }else{
        setState(() {
          userRole = kRoles[0];
          isLoading = false;
        });
        await SherdPrefHelper().setUserRole(kRoles[0]);
      }
    }else{
      
  userRole = await SherdPrefHelper().getUserRole();
setState(() {
  
});
      isLoading = false;
    }
  }

  @override
  void initState() {
    super.initState();
    checkRole();
        BlocProvider.of<DeleteOldDataCubit>(context).deleteOldData();

  }

  @override
  Widget build(BuildContext context) {
    return isLoading && userRole == null
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
                page: const TimeLineVeiw(
                  calendarView: CalendarView.month,
                ), text: S.of(context).time_line,icon: Icons.calendar_month,),

             Visibility(
              visible: userRole==kRoles[1] || userRole==kRoles[2],
               child: Card_Button(
                page: const BookLocView(), text: S.of(context).add_event,icon: Icons.add,),
             ),

            Visibility(
                visible: userRole==kRoles[2],
                child:  Card_Button(
                  color: Colors.red,
                    page: const BottomNavBar(),
                    icon: Icons.admin_panel_settings_rounded,
                    text: S.of(context).admin_panel)),
          ],
        );
  }
}
