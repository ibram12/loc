import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loc/core/helper/delightful_toast.dart';
import '../../../../core/server/shered_pref_helper.dart';
import '../../../admin/pressntation/widgets/custom_bottom_sheet_body.dart';
import '../manager/set_user_image_cubit/set_user_image_cubit.dart';

class UserImage extends StatefulWidget {
  const UserImage({super.key});

  @override
  State<UserImage> createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  File? image;

  Future<File?> getLocalUserImage() async {
    final imagePath = await SherdPrefHelper().getUserImage();
    if (imagePath == null || imagePath.isEmpty) {
      return null;
    }
    return File(imagePath);
  }

  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
      BlocProvider.of<SetUserImageCubit>(context).setUserImage(image);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SetUserImageCubit, SetUserImageState>(
      builder: (context, state) {
        if (state is SetUserImageError) {
          showDelightfulToast(
              message: state.error, context: context, dismiss: true);
        }
        return GestureDetector(
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
              },
            );
          },
          child: FutureBuilder<File?>(
            future: getLocalUserImage(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.grey.shade200,
                  child: const CircularProgressIndicator(),
                );
              } else if (snapshot.hasData && snapshot.data != null) {
                return CircleAvatar(
                  radius: 25,
                  backgroundImage: FileImage(snapshot.data!),
                  child: state is SetUserImageLoading
                      ? const CircularProgressIndicator()
                      : null,
                );
              } else {
                return CircleAvatar(
                  radius: 25,
                  backgroundImage: const AssetImage('assets/images/person.png'),
                  child: state is SetUserImageLoading
                      ? const CircularProgressIndicator()
                      : null,
                );
              }
            },
          ),
        );
      },
    );
  }
}
