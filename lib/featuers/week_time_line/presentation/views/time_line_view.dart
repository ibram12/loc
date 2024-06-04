
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/featuers/week_time_line/presentation/manager/show_time_line_cubit/show_time_line_cubit.dart';
import 'package:loc/featuers/week_time_line/presentation/views/widgets/time_line_view_body.dart';

class TimeLineVeiw extends StatelessWidget {
  const TimeLineVeiw({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShowTimeLineCubit(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
    forceMaterialTransparency: true,
          title: const Text('Time Line'),
        ),
        body: const TimeLineViewBody(),
      ),
    );
  }
}
