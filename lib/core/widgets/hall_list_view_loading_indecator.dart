import 'package:flutter/material.dart';
import 'package:loc/core/widgets/custom_fadding_widget.dart';
import 'package:loc/core/widgets/custom_hall_loading_indecator.dart';

class HallListViewLoadingIndecator extends StatelessWidget {
  const HallListViewLoadingIndecator({super.key, required this.scrollDirection});
  final Axis scrollDirection;
  @override
  Widget build(BuildContext context) {
    return CustomFaddingWidget(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2
        ),
          scrollDirection:scrollDirection,
          itemCount: 10,
          itemBuilder: (context, index) {
            return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: CustomHallLoadingIndecator());
          }),
    );
  }
}
