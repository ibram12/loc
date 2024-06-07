import 'package:flutter/material.dart';

import '../../../../core/text_styles/Styles.dart';
import '../../../../generated/l10n.dart';
import '../widgets/all_users_view_body.dart';

class AllUsersView extends StatefulWidget {
  const AllUsersView({super.key});

  @override
  State<AllUsersView> createState() => _AllUsersViewState();
}

class _AllUsersViewState extends State<AllUsersView> {
  bool isDeleted = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title:  Text(S.of(context).all_users,style: Styles.textStyle20,),
      ),
      body:const AllUsersViewBody()
    );
  }
}