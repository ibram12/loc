import 'package:flutter/material.dart';

class DayByDayTableView extends StatefulWidget {
  const DayByDayTableView({super.key});

  @override
  State<DayByDayTableView> createState() => _DayByDayTableViewState();
}

class _DayByDayTableViewState extends State<DayByDayTableView> {
  bool isDeleted = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(seconds: 3),
        child: Card(
          child: Container(),
        ),
      ),
    );
  }
}