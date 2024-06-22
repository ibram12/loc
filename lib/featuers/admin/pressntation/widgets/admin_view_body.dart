import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:loc/featuers/admin/pressntation/manager/featch_end_times_cubit/featch_the_end_times_cubit.dart';
import 'package:loc/featuers/admin/pressntation/widgets/all_halls_list_veiw.dart';

import '../view/add_hall_view.dart';

class AdminViewBody extends StatelessWidget {
  const AdminViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeatchTheEndTimesCubit(),
      child: Stack(
        children: [
          const AllHallsListView(),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: kPrimaryColor,
              shape: const CircleBorder(),
              onPressed: () {
                Navigator.of(context).pushNamed(AddHallView.id);
              },
              child: const Icon(Icons.add),
            ),
          )
        ],
      ),
    );
  }
}
