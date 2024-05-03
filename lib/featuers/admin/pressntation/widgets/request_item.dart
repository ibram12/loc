import 'package:flutter/material.dart';

class RequestItem extends StatelessWidget {
  const RequestItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        title: const Text('RequestsViewBody'),
        subtitle:const Text('ramez'),
        trailing:const Text('ramez'),
        leading:const Text('ramez'),
        textColor: Colors.black,
        tileColor: Colors.blue,
      ),
    );
  }
}