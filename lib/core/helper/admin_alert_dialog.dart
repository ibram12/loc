import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../featuers/admin/data/models/request_model.dart';

void adminAlrtDialog(
    {required BuildContext context, required Function() onAccept, required Function() onEdit, required Function() onReject,required RequestModel requestModel,required String hallName}) {
showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Alert'),
            
            IconButton(onPressed: () => Navigator.of(context).pop(), icon:  Icon(Icons.close, color: Colors.red[900], size: 20),) 
            ],
          ),
          content: RichText(
  text: TextSpan(
    children: [
      TextSpan(
        text: requestModel.name,
          style: const TextStyle(
          fontWeight: FontWeight.bold, 
          fontSize: 16,
          color: Colors.black, 
        ),
      ),
      TextSpan(
        text: ' needs to book $hallName on ${requestModel.sendDate} from ',
        style: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 16, 
          color: Colors.black, 
        ),
      ),
      TextSpan(
        text: DateFormat.jm().format(requestModel.startTime.toDate()),
        style: const TextStyle(
          fontWeight: FontWeight.bold, 
          fontSize: 16,
          color: Colors.black, 
        ),
      ),
      const TextSpan(
        text: ' to ',
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 16, 
          color: Colors.black, 
        ),
      ),
      TextSpan(
        text: DateFormat.jm().format(requestModel.endTime.toDate()),
        style: const TextStyle(
          fontWeight: FontWeight.bold, 
          fontSize: 16, 
          color: Colors.black, 
        
        ),
      ),
    ],
  ),
),
          actions: [
            TextButton(
              onPressed: onAccept,
              child: const Text('Accept',style: TextStyle(color: Colors.green),),
            ),
            Row(
              children: [
                    TextButton(
              onPressed: onEdit,
              child: const Text('edit',style: TextStyle(color: Colors.blue),),
            ),
                TextButton(
                  onPressed: onReject,
                  child: const Text('Rejection the request',style: TextStyle(color: Colors.red),),
                ),
              
              ],
            ),
          
          ],
        );
      },
    );
}
