import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/featuers/admin/pressntation/manager/signUp_cubit/sign_up_cubit.dart';
import 'package:loc/featuers/admin/pressntation/view/admin_view.dart';
import 'package:loc/featuers/admin/pressntation/view/all_users_view.dart';
import 'package:loc/featuers/admin/pressntation/view/sginup_view.dart';

import '../../../../core/utils/constants.dart';
import '../manager/signUp_cubit/sign_up_state.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int pageIndex = 1;
  bool canNavigate = true;
  late List<Widget> pagesList;
  late AdminView adminView;
  late SignUpView signUpView;
  late AllUsersView timeLineView;

  @override
  void initState() {
    adminView = const AdminView();
    signUpView = const SignUpView();
    timeLineView = const AllUsersView();
    pagesList = [timeLineView, adminView, signUpView];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: BlocListener<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state is SignUpLoading) {
            setState(() {
              canNavigate = false;
            });
          } else {
            setState(() {
              canNavigate = true;
            });
          }
        },
        child: Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            index: pageIndex,
            animationDuration: const Duration(milliseconds: 300),
            height: 55,
            color: kPrimaryColor,
            buttonBackgroundColor: kPrimaryColor,
            backgroundColor: Colors.transparent,
            onTap: (index) {
              if (canNavigate) {
                setState(() {
                  pageIndex = index;
                });
              }
            },
            items: const [
              Icon(
                Icons.people_alt_sharp,
                color: Colors.white,
              ),
              Icon(
                Icons.home_outlined,
                color: Colors.white,
              ),
              Icon(
                Icons.person_add_alt_1_outlined,
                color: Colors.white,
              )
            ],
          ),
          body: pagesList[pageIndex],
        ),
      ),
    );
  }
}
