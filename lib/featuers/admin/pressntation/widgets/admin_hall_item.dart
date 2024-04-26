import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/text_styles/Styles.dart';
import '../../../book_Hall/data/models/hall_model.dart';

class AdminHallItem extends StatelessWidget {
  const AdminHallItem({
    super.key,
    required this.hallModel,required this.onLongPress,
  });
  final HallModel hallModel;
  final void Function() onLongPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onLongPress,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Material(
          clipBehavior: Clip.antiAlias,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 8,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
              child: CachedNetworkImage(
                errorWidget: (context, url, error) {
                  return const Icon(Icons.error);
                },
                imageUrl: hallModel.image,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
            Text(
              " ${hallModel.name}",
              style: Styles.textStyle20,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "  ${hallModel.floor}",
                  style: Styles.textStyle18,
                ),
                const Spacer(),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}