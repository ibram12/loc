import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfoModel {
  final String name;
  final String email;
  final String role;
  final String imageUrl;
  final String id;
  final List services;
  UserInfoModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.imageUrl,
    required this.services,
  });

  factory UserInfoModel.fromDocumentSnapshot(
      DocumentSnapshot documentSnapshot) {
    return UserInfoModel(
        id:documentSnapshot['id'],
        name: documentSnapshot['name'],
        email: documentSnapshot['email'],
        role: documentSnapshot['role'],
        imageUrl: documentSnapshot['image'],
        services: documentSnapshot['service']);
  }
}
