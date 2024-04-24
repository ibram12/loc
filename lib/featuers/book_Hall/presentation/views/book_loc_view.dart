import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:loc/featuers/book_Hall/presentation/manager/cubits/cubit/select_time_cubit.dart';
import 'package:loc/featuers/book_Hall/presentation/views/widgets/book_loc_view_body.dart';

import '../../../../generated/l10n.dart';

class BookLocView extends StatelessWidget {
  const BookLocView({Key? key, required this.image}) : super(key: key);
 final String image;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SelectTimeCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text(S.of(context).add_reservation),
        ),
        body: BookLocViewBody(
          image: image,
        ),
      ),
    );
  }
}
