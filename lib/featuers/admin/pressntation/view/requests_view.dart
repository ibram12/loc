import 'package:flutter/material.dart';
import 'package:loc/core/text_styles/Styles.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:loc/featuers/admin/pressntation/widgets/%60requests_view_body.dart';

class RequestsView extends StatelessWidget {
  const RequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('Hall name',style: Styles.textStyle20,),
      ),
      body: const RequestsViewBody(),
    );
  }
}