import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/core/text_styles/Styles.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:loc/featuers/settings/presentaiton/manager/log_out_cubit/log_out_cubit.dart';
import 'package:loc/featuers/settings/presentaiton/manager/set_user_image_cubit/set_user_image_cubit.dart';
import 'package:loc/featuers/settings/presentaiton/widgets/devaloper_profile.dart';
import 'package:loc/featuers/settings/presentaiton/widgets/drower_body.dart';
import 'package:loc/featuers/settings/presentaiton/widgets/user_image.dart';
import '../../../../generated/l10n.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SetUserImageCubit(),
        ),
        BlocProvider(
          create: (context) => LogOutCubit(),
        ),
      ],
      child: Drawer(
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: const BoxDecoration(color: kOrange),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).profile,
                        style: Styles.textStyle18.copyWith(color: Colors.white),
                      ),
                      const UserImage(),
                    ],
                  ),
                ),
                const DrowerBody(),
              ],
            ),
            const DevaloperProfile()
          ],
        ),
      ),
    );
  }
}
