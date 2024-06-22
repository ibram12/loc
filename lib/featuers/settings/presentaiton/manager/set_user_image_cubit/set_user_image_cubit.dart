import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:loc/core/server/shered_pref_helper.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';

part 'set_user_image_state.dart';

class SetUserImageCubit extends Cubit<SetUserImageState> {

  SetUserImageCubit() : super(SetUserImageInitial());

  Future<void> setUserImage(File? image) async {
    emit(SetUserImageLoading());
    String userId = FirebaseAuth.instance.currentUser!.uid;
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('userImages')
        .child('${DateTime.now()}');

    UploadTask uploadTask = ref.putFile(image ?? File(''));

    var url = await (await uploadTask).ref.getDownloadURL();

  await  FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({'image': url}).catchError((error, stackTrace) {
          emit(SetUserImageError(error: 'your image Not uploaded'));
        });

    await SherdPrefHelper().setUserImage(await _saveImageLocally(image));
    FirebaseAuth.instance.currentUser!.updatePhotoURL(url);//my be you not need it

    if (!isClosed) {
  emit(SetUserImageSuccess(imageUrl: url));
}
  }

  Future<String> _saveImageLocally(File? image) async {
    if (image == null) {
      return '';
    }
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final fileName = 'userImage_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final localImage = File('$path/$fileName');
    await image.copy(localImage.path);
    return localImage.path;
  }

  
}
