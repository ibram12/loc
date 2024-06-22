import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/featuers/auth/presentation/views/login_view.dart';

import '../../../../core/helper/delete_alert_dialog.dart';
import '../../../../core/text_styles/Styles.dart';
import '../../../../generated/l10n.dart';
import '../manager/log_out_cubit/log_out_cubit.dart';

class LogOutBotton extends StatelessWidget {
  const LogOutBotton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogOutCubit, LogOutState>(
      listener: (context, state) {
      if (state is LogOutSuccess) {
        Navigator.of(context).pushNamedAndRemoveUntil(LoginView.id, (route)=> false);
      }
      },
      child: GestureDetector(
        onTap: () => showItemAlertDialog(
            showDeletetionText: false,
            context: context,
            onPressed: () {
              BlocProvider.of<LogOutCubit>(context).logOut();
            },
            title: S.of(context).log_out,
            content: S.of(context).are_you_sure_you_want_to_log_out),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.of(context).log_out,
              style: Styles.textStyle16.copyWith(fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Icon(
                Icons.logout,
              ),
            )
          ],
        ),
      ),
    );
  }
}
