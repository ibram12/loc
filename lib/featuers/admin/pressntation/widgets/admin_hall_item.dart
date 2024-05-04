import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loc/featuers/admin/pressntation/view/requests_view.dart';

import '../../../../core/text_styles/Styles.dart';
import '../../../book_Hall/data/models/hall_model.dart';

class AdminHallItem extends StatefulWidget {
  const AdminHallItem({
    super.key,
    required this.hallModel,
    required this.onLongPress,
    required this.hallid,// required this.revarsations,
  });
  final HallModel hallModel;
  final void Function() onLongPress;
  final String hallid;
  // final int revarsations;

  @override
  State<AdminHallItem> createState() => _AdminHallItemState();
}

class _AdminHallItemState extends State<AdminHallItem> {
  int revarsations = 0;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return RequestsView(
            hallId: widget.hallid,
            hallName: widget.hallModel.name,
            onNumberOfDocsChanged: (count) {
                revarsations = count;
            },
          );
        }));
      },
      onLongPress: widget.onLongPress,
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
                imageUrl: widget.hallModel.image,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
            Text(
              " ${widget.hallModel.name}",
              style: Styles.textStyle20,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "  ${widget.hallModel.floor}",
                  style: Styles.textStyle18,
                ),
                const Spacer(),
                CircleAvatar(
                  backgroundColor: Colors.green,
                  child: revarsations==0? Text('${widget.hallModel.reversationsCount}'):Text('$revarsations'),
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
