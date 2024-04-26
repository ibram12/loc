import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loc/featuers/admin/pressntation/widgets/custom_bottom_sheet_body.dart';

class CustomImageContaner extends StatefulWidget {
  const CustomImageContaner({super.key});

  @override
  State<CustomImageContaner> createState() => _CustomImageContanerState();
}

class _CustomImageContanerState extends State<CustomImageContaner> {
  File? image;

  Future<void> pickImagef(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
      Navigator.pop(context);

    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return BottomSheetBody(
                chooseCamera: () {
                  pickImagef(ImageSource.camera);
                },
                chooseGallery: () {
                  pickImagef(ImageSource.gallery);
                },
              );
            });
      },
      child: Container(
        height: size.height * 0.3,
        width: size.width * 0.5,
        margin: const EdgeInsets.symmetric(vertical: 30),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(10)),
        child: image == null
            ? const Icon(
                Icons.camera_alt_outlined,
                size: 50,
              )
            : Image.file(
                image!,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
