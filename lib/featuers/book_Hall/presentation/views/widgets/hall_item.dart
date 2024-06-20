import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loc/core/text_styles/Styles.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:loc/featuers/book_Hall/data/models/hall_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HallItem extends StatefulWidget {
  const HallItem({
    super.key,
    required this.hallModel,
    required this.hallId,
    required this.selectedHalls,
    required this.onSelectionChanged,
  });
  final HallModel hallModel;
  final String hallId;
  final List<String> selectedHalls;
  final Function(bool isSelected, String hallId) onSelectionChanged;

  @override
  State<HallItem> createState() => _HallItemState();
}

class _HallItemState extends State<HallItem> {
  bool isSelected = false;
  bool? isDarkMode; 

  @override
  void initState() {
    super.initState();
    fetchThemeMode();
  }

  Future<void> fetchThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('themeMode') == true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isDarkMode == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          setState(() {
            isSelected = !isSelected;
            widget.onSelectionChanged(isSelected, widget.hallId);
          });
        },
        child: Material(
          clipBehavior: Clip.antiAlias,
          color: isSelected
              ? kPrimaryColor
              : isDarkMode  == false || isDarkMode == null
                  ? Colors.white
                  : Colors.black,
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
                const Icon(
                  Icons.circle_rounded,
                  color:  Colors.green 
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
