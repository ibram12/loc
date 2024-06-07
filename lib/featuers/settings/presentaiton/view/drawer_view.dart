import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/core/text_styles/Styles.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:loc/featuers/settings/presentaiton/manager/set_user_image_cubit/set_user_image_cubit.dart';
import 'package:loc/featuers/settings/presentaiton/widgets/drower_body.dart';
import 'package:loc/featuers/settings/presentaiton/widgets/user_image.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SetUserImageCubit(),
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: kOrange
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Profile',
                    style: Styles.textStyle18.copyWith(color: Colors.white),
                  ),
                  const UserImage(),
                ],
              ),
            ),
            
            const DrowerBody()
          ],
        ),
      ),
    );
  }
}
