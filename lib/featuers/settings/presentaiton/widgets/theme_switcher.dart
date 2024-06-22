
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/theme_cubit/theme_cubit.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';



class SwitchThemeApp extends StatefulWidget {
  const SwitchThemeApp({
    super.key,
  });

  @override
  State<SwitchThemeApp> createState() => _SwitchThemeAppState();
}

class _SwitchThemeAppState extends State<SwitchThemeApp> {
  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();

    return Switch(
      activeTrackColor: Colors.grey,
      inactiveTrackColor: Colors.grey,
      activeColor: Colors.white,
      activeThumbImage: const AssetImage('assets/images/sun.webp'),
      inactiveThumbImage: const AssetImage('assets/images/moon.png'),
      inactiveThumbColor: Colors.black12,
      value: context.watch<ThemeCubit>().state == ThemeMode.dark,
      onChanged: (value) {
        themeCubit.switchTheme();
      },
    );
  }
}