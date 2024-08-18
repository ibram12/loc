import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/core/text_styles/Styles.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:loc/featuers/home/presentaiton/manager/delete_old_data_cubit/delete_old_data_cubit.dart';
import 'package:loc/featuers/home/presentaiton/manager/get_user_role_cubit/get_user_role_cubit.dart';
import 'package:loc/featuers/requests/presentatoin/views/requests_view.dart';
import 'package:loc/featuers/settings/presentaiton/view/drawer_view.dart';
import 'package:provider/provider.dart';

import '../../../../core/notifications/notification_manager/notification_manager_cubit/notification_maneger_cubit.dart';
import '../../../../generated/l10n.dart';
import '../manager/get_user_namecubit/get_user_name_cubit.dart';
import '../widgets/home_view_body.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });
  static const String id = "MyHomePage";

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    final notificationManagerCubit = context.read<NotificationManegerCubit>();
    notificationManagerCubit.onNotificationTapped(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DeleteOldDataCubit(),
        ),
        BlocProvider(
          create: (context) => GetUserRoleCubit(),
        ),
        BlocProvider(create: (context)=> GetUserNameCubit()..getUserName()),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: BlocBuilder<GetUserNameCubit, GetUserNameState>(
            builder: (context, state) {
              return Text(
              state is GetUserNameSuccess ?  '${S.of(context).wellcome} ${state.userName}': S.of(context).wellcome,
                style: Styles.textStyle18,
              );
            },
          ),
          leading: Builder(builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu_rounded),
            );
          }),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const UserRequests()));
              },
              icon: const Icon(Icons.notifications),
            ),
          ],
        ),
        drawer: const DrawerView(),
        body: const HomeVeiwBody(),
      ),
    );
  }
}
