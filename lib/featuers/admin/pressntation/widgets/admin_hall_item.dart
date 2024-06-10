import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loc/featuers/admin/data/models/admin_hall_model.dart';
import 'package:loc/featuers/admin/pressntation/view/requests_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/text_styles/Styles.dart';

class AdminHallItem extends StatefulWidget {
  const AdminHallItem({
    Key? key,
    required this.hallModel,
    required this.onLongPress,
    required this.hallid,
    this.remainingTime,
  }) : super(key: key);

  final AdminHallModel hallModel;
  final VoidCallback onLongPress;
  final String hallid;
  final Duration? remainingTime;

  @override
  State<AdminHallItem> createState() => _AdminHallItemState();
}

class _AdminHallItemState extends State<AdminHallItem> {
  int revarsations = 0;
  late Duration? _remainingTime;
  Timer? _timer;
  bool? isDarkMode;

  Future<void> fetchThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('themeMode') == true;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
  _remainingTime = widget.remainingTime;
});
    if (_remainingTime != null) {
      _startTimer();
    }
    fetchThemeMode();
  }

  @override
  void didUpdateWidget(covariant AdminHallItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.remainingTime != widget.remainingTime) {
      _timer?.cancel();
      _remainingTime = widget.remainingTime;
      if (_remainingTime != null) {
        _startTimer();
      }
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime != null) {
        setState(() {
          _remainingTime = _remainingTime! - const Duration(seconds: 1);
          if (_remainingTime!.isNegative) {
            timer.cancel();
            _remainingTime = null;
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isDarkMode == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return RequestsView(
            hallId: widget.hallid,
            hallName: widget.hallModel.name,
            onNumberOfDocsChanged: (count) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                setState(() {
                  revarsations = count;
                });
              });
            },
          );
        }));
      },
      onLongPress: widget.onLongPress,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Material(
              clipBehavior: Clip.antiAlias,
              color: isDarkMode! ? Colors.black : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                      if (widget.hallModel.reversationsCount != 0)
                        CircleAvatar(
                          backgroundColor: Colors.green,
                          child: revarsations == 0
                              ? Text('${widget.hallModel.reversationsCount}')
                              : Text('$revarsations'),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (_remainingTime != null)
            Positioned(
              right: 10,
              top: 10,
              child: CircleAvatar(
                backgroundColor: Colors.white70,
                radius: _remainingTime!.inMinutes > 60 ? 23 : 21,
                child: Text(
                  formatDuration(_remainingTime!),
                  style: TextStyle(
                    fontSize: _remainingTime!.inMinutes > 60 ? 12 : 15,
                    color: Colors.red,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}

String formatDuration(Duration duration) {
  final hours = duration.inHours;
  final minutes = duration.inMinutes.remainder(60);
  final seconds = duration.inSeconds.remainder(60);

  if (hours > 0) {
    return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  } else {
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}
