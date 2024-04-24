import 'package:flutter/material.dart';

import 'halls_list_view.dart';

class AllLocsViewBody extends StatelessWidget {
  const AllLocsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
      HallsListView(),
     ]);
  }
}
