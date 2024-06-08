import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loc/generated/l10n.dart';

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
               Text(S.of(context).alert),
            
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
        text: ' ${S.of(context).needs_to_book} $hallName ${S.of(context).on} ${requestModel.sendDate} ${S.of(context).from} ',
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
       TextSpan(
        text: ' ${S.of(context).to} ',
        style: const TextStyle(
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
          
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                    TextButton(
              onPressed: onEdit,
              child:  Text(S.of(context).edit,style: const TextStyle(color: Colors.blue),),
            ),
                TextButton(
                  onPressed: onReject,
                  child:  Text(S.of(context).reject,style: const TextStyle(color: Colors.red),),
                ),
                TextButton(
              onPressed: onAccept,
              child:  Text(S.of(context).accept,style: const TextStyle(color: Colors.green),),
            ),
              ],
            ),
          
          ],
        );
      },
    );
}
