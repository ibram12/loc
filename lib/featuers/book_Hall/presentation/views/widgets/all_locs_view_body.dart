import 'package:flutter/material.dart';

import '../book_Loc_view.dart';
import 'halls_list_view.dart';

class AllLocsViewBody extends StatelessWidget {
  const AllLocsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[
      const HallsListView(),
      Positioned(
        bottom: 20,
        right: 20,
        child: FloatingActionButton(
          onPressed: () {
         Navigator.of(context).pushNamed(BookLocView.id);
          }
        ,child: const Icon(Icons.add),)),

    ] 
    );
  }
}