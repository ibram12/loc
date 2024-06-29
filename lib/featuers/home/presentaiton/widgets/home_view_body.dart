import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:loc/featuers/admin/pressntation/view/sginup_view.dart';
import 'package:loc/featuers/home/presentaiton/manager/get_user_role_cubit/get_user_role_cubit.dart';
import 'package:loc/featuers/time_line/presentation/views/time_line_view.dart';
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
  @override
  initState() {
    super.initState();
    context.read<GetUserRoleCubit>().getUserRole();
    context.read<DeleteOldDataCubit>().deleteOldData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUserRoleCubit, GetUserRoleState>(
      builder: (context, state) {
        if (state is GetUserRoleLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetUserRoleSuccess) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: Image.asset(
                      kLogo,
                      height: MediaQuery.of(context).size.height * .31,
                    )),
                Card_Button(
                  page: const TimeLineVeiw(
                    calendarView: CalendarView.month,
                  ),
                  text: S.of(context).time_line,
                  icon: Icons.calendar_month,
                ),
                Visibility(
                  visible: state.userRole == kRoles[1] ||
                      state.userRole == kRoles[2],
                  child: Card_Button(
                    page: const BookLocView(),
                    text: S.of(context).add_event,
                    icon: Icons.add,
                  ),
                ),
                state.userRole == kRoles[2]
                    ? Card_Button(
                        color: Colors.red,
                        page: const BottomNavBar(),
                        icon: Icons.admin_panel_settings_rounded,
                        text: S.of(context).admin_panel)
                    : Visibility(
                        visible: state.userRole == kRoles[1],
                        child: Card_Button(
                          color: Colors.red,
                          page: const SignUpView(),
                          text: S.of(context).add_new_user,
                          icon: Icons.person_add,
                        ),
                      ),
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
