import 'package:flutter/material.dart';

class CustomHallLoadingIndecator extends StatelessWidget {
  const CustomHallLoadingIndecator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AspectRatio(
          aspectRatio: 2.8 / 4,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child:  Container(
              color: Colors.grey,
            )
            )
            ),
    );
  }
}