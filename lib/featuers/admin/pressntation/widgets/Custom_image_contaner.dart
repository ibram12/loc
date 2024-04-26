import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loc/core/text_styles/Styles.dart';
import 'package:loc/featuers/admin/pressntation/widgets/custom_bottom_sheet_body.dart';

class CustomImageContaner extends StatelessWidget {
  const CustomImageContaner({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return const BottomSheetBody();
            });
      },
      child: Container(
        height: size.height * 0.3,
        width: size.width * 0.5,
        margin: const EdgeInsets.symmetric(vertical: 30),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(10)),
        child: const Icon(
          Icons.camera_alt_outlined,
          size: 50,
        ),
      ),
    );
  }
}
