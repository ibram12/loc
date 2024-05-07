import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loc/featuers/admin/pressntation/manager/add_hall_cubit/add_hall_cubit.dart';
import 'package:loc/featuers/admin/pressntation/widgets/custom_bottom_sheet_body.dart';

class CustomImageContaner extends StatefulWidget {
  const CustomImageContaner({super.key, required this.onSelected});
  final void Function(File) onSelected;

  @override
  State<CustomImageContaner> createState() => _CustomImageContanerState();
}

class _CustomImageContanerState extends State<CustomImageContaner> {
  File? image;

  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
      widget.onSelected(image!);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocListener<AddHallCubit, AddHallState>(
      listener: (context, state) {
        if (state is AddHallSuccess) {
          image = null;
        }
      },
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return BottomSheetBody(
                  chooseCamera: () {
                    pickImage(ImageSource.camera);
                  },
                  chooseGallery: () {
                    pickImage(ImageSource.gallery);
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
              : ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    image!,
                    fit: BoxFit.fill,
                  ),
                ),
        ),
      ),
    );
  }
}
