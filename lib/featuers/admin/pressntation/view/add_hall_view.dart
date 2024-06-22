import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/featuers/admin/pressntation/manager/add_hall_cubit/add_hall_cubit.dart';
import 'package:loc/featuers/admin/pressntation/widgets/add_hall_view_body.dart';

import '../../../../core/utils/constants.dart';
import '../../../../generated/l10n.dart';

class AddHallView extends StatelessWidget {
  const AddHallView({super.key});

  static const String id = "AddHallView";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddHallCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text(S.of(context).add_hall),
        ),
        
        body: const AddHallViewBody(),
      ),
    );
  }
}
