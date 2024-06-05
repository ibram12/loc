import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loc/featuers/admin/data/models/user_info_model.dart';

import '../../../../core/text_styles/Styles.dart';

class UserInfoCard extends StatelessWidget {
  const UserInfoCard({super.key, required this.userInfoModel});
  final UserInfoModel userInfoModel;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      elevation: 3,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 34,
          child: ClipOval(
            child: CachedNetworkImage(
                placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                fit: BoxFit.fill,
                errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                imageUrl: userInfoModel.imageUrl),
          ),
        ),
        title: SizedBox(
            child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '${userInfoModel.name} ',
                style: Styles.textStyle18.copyWith(color: Colors.black),
              ),
              TextSpan(
                text: '(${userInfoModel.role})',
                style: Styles.textStyle14.copyWith(color: Colors.deepOrange),
              ),
            ],
          ),
        )),
        subtitle: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userInfoModel.email,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              userInfoModel.services.join(', '),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        trailing: IconButton( 
          padding: const EdgeInsets.only(left: 15),
          onPressed: () {},
          icon: const Icon(Icons.edit),
        ),
      ),
    );
  }
}
