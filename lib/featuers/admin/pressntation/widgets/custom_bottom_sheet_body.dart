import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/text_styles/Styles.dart';
import '../../../../core/utils/constants.dart';
import '../../../../generated/l10n.dart';

class BottomSheetBody extends StatelessWidget {
  const BottomSheetBody(
      {super.key, required this.chooseGallery, required this.chooseCamera});
  final void Function() chooseGallery;
  final void Function() chooseCamera;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: chooseCamera,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const CircleAvatar(
                radius: 25,
                backgroundColor: kOrange,
                child: Icon(Icons.camera_alt),
              ),
               Text(
                S.of(context).camera,
                style: Styles.textStyle14,
              )
            ]),
          ),
          InkWell(
            onTap: chooseGallery,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const CircleAvatar(
                radius: 25,
                backgroundColor: kOrange,
                child: Icon(Icons.image),
              ),
               Text(
                S.of(context).gallery,
                style: Styles.textStyle14,
              )
            ]),
          ),
        ],
      ),
    );
  }
}
