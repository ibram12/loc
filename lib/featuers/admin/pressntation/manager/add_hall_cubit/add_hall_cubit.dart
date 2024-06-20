import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/core/server/firebase_methoudes.dart';
import 'package:meta/meta.dart';

part 'add_hall_state.dart';

class AddHallCubit extends Cubit<AddHallState> {
  AddHallCubit() : super(AddHallInitial());
  Future<void> addHall(String floor, String name, File? image) async {
    try {
      emit(AddHallLoading());
      
        Reference ref =
           FirebaseStorage.instance.ref().child('images').child('${DateTime.now()}');

      UploadTask uploadTask = ref.putFile(image?? File(''));

      var url = await (await uploadTask).ref.getDownloadURL();

      Map<String, dynamic> locInfo = {
        'image': url,
        'floor': floor,
        'name': name,
        'available': true
      };
      await DataBaseMethouds().addHall(locInfo);
      emit(AddHallSuccess());
    } catch (e) {
      emit(AddHallError());
    }
  }
}