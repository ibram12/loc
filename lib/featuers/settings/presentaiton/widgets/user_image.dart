import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:path_provider/path_provider.dart';
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
    final user = FirebaseAuth.instance.currentUser;
    if(user!.photoURL != null){
        final photoUrl = user.photoURL!;
        // Fetch the image from the URL
        final response = await HttpClient().getUrl(Uri.parse(photoUrl));
        final responseBody = await response.close();
        final bytes = await consolidateHttpClientResponseBytes(responseBody);
        final tempDir = await getTemporaryDirectory();
        final file = await File('${tempDir.path}/user_photo.jpg').writeAsBytes(bytes);
        SherdPrefHelper().setUserImage(file.path);
        return file;
    }

      return null;
    }

    return File(imagePath);
  }

  final customAspectRatio = const CropAspectRatio(
  ratioX: 1.0, 
  ratioY: 1.0,
);

  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9,
        ],
        aspectRatio: customAspectRatio,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: kOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true,
          ),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );

      if (croppedFile != null) {
        setState(() {
          image = File(croppedFile.path);
        });
        BlocProvider.of<SetUserImageCubit>(context).setUserImage(image);
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SetUserImageCubit, SetUserImageState>(
      builder: (context, state) {
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
              if (snapshot.connectionState == ConnectionState.waiting || state is SetUserImageLoading) {
                return const CircleAvatar(
                  radius: 50,
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData && snapshot.data != null) {
                return CircleAvatar(
                  radius: 50,
                  backgroundImage: FileImage(snapshot.data!),
                );
              } else {
                return const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/person.png'),
                );
              }
            },
          ),
        );
      },
    );
  }
}
