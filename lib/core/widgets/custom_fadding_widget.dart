import 'package:flutter/material.dart';

class CustomFaddingWidget extends StatefulWidget {
  const CustomFaddingWidget({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<CustomFaddingWidget> createState() => _CustomFaddingWidgetState();
}

class _CustomFaddingWidgetState extends State<CustomFaddingWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    animation = Tween<double>(begin: .2, end: .8).animate(controller);
    controller.addListener(() {
      setState(() {});
    });
    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
        controller.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: animation.value,
      child: widget.child,
    );
  }
}
