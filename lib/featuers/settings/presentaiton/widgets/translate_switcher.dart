import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/local_cubit/local_cubit.dart';

class TranslateSwitcher extends StatefulWidget {
  const TranslateSwitcher({super.key});

  @override
  State<TranslateSwitcher> createState() => _TranslateSwitcherState();
}

class _TranslateSwitcherState extends State<TranslateSwitcher> {
  @override
  Widget build(BuildContext context) {
    final localeCubit = context.read<LocaleCubit>();

    return Switch(
      activeTrackColor: Colors.grey,
      inactiveTrackColor: Colors.grey,
      activeColor: Colors.white,
      inactiveThumbColor: Colors.black12,
      value: context.watch<LocaleCubit>().state.languageCode == 'ar',
      onChanged: (value) {
        localeCubit.switchLocale();
      },
    );
  }
}
