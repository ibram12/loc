import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loc/core/text_styles/Styles.dart';

class UserRequestItem extends StatelessWidget {
  const UserRequestItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 3,
        margin:const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Padding(
          padding:const EdgeInsets.all(10),
          child: Row(
            children: [
              Column(
                // mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'hallName',
                    overflow: TextOverflow.fade,
                  style: Styles.textStyle18,
                  ),
                const  SizedBox(height: 5),
                  const Text(
                    'Date: 23/2/2023',
                    style: Styles.textStyle16,
                  ),
              const    SizedBox(height: 5),
                  Text(
                     'Start Time: ${DateFormat('hh:mm a').format(DateTime.now())}',
                    style: Styles.textStyle16,
                  ),
              const    SizedBox(height: 5),
                  Text(
                   'End Time: ${DateFormat('hh:mm a').format(DateTime.now())}',
                    style: Styles.textStyle16,
                  ),
                ],
              ),
              const Spacer(),
                const CircleAvatar(
                  backgroundColor: Colors.green,
                radius: 20,
                child: Icon(Icons.check,color: Colors.white,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}