import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../manager/cubits/select_time_cubit/select_time_cubit.dart';

class UserChoices extends StatefulWidget {
  const UserChoices({
    super.key,
  });

  @override
  State<UserChoices> createState() => _UserChoicesState();
}

class _UserChoicesState extends State<UserChoices> {
  late SelectTimeCubit selectTimeCubit;
  @override
  void initState() {
    // TODO: implement initState
    selectTimeCubit = BlocProvider.of<SelectTimeCubit>(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      ElevatedButton(
          onPressed: () => selectTimeCubit.selectDate(context),
          child: const Text('Make Reservation')),
  
    ]);
  }
}
