import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/text_styles/Styles.dart';

class BottomSheetBody extends StatelessWidget {
  const BottomSheetBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.only(top: 25,bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.grey.shade300,
                          child: const Icon(Icons.camera_alt),
                        ),
                      const Text(
                        'Camera',
                        style: Styles.textStyle14,
                      )
                    ]),
                      Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.grey.shade300,
                          child: const Icon(Icons.image),
                        ),
                      const Text(
                        'Gallery',
                        style: Styles.textStyle14,
                      )
                    ]),
                  ],
                ),
              );
  }
}