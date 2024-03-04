import 'package:flutter/material.dart';

import '../father class/TimeActivity.dart';
import '../widget/card_DateTime.dart';

class AddActivity extends StatefulWidget {
  @override
  _AddActivityState createState() => _AddActivityState();
}

class _AddActivityState extends State<AddActivity> {
  TimeActivity? timeActivity;
  List<bool> isCheckedList = List.generate(5, (index) => false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 300,
                child: Expanded(
                  child: ListView.builder(
                    itemCount: isCheckedList.length,
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                        title: Text('Item $index'),
                        value: isCheckedList[index],
                        onChanged: (value) {
                          setState(() {
                            isCheckedList[index] = value!;
                          });
                        },
                      );
                    },
                  ),
                ),
              ),
              card_DateTime(
                onDateTimeSelected: (selectedTimeActivity) {
                  setState(() {
                    timeActivity = selectedTimeActivity;
                  });
                },
              ),
              if (timeActivity != null)
                Text(
                  "تاريخ البداية: ${timeActivity!.startTime}\nتاريخ النهاية: ${timeActivity!.endTime}",
                ),

            ],
          ),
        ),
      ),
    );
  }
}