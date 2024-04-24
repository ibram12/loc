import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loc/core/text_styles/Styles.dart';
import 'package:loc/featuers/book_Hall/data/models/hall_model.dart';

import '../book_loc_view.dart';

class HallItem extends StatelessWidget {
  const HallItem({
    super.key,
    required this.hallModel,
  });
  final HallModel hallModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return BookLocView(image: hallModel.image);
          }));
        },
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
                Icon(
                  Icons.circle_rounded,
                  color: hallModel.isBooked ? Colors.green : Colors.red,
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
