import 'package:flutter/material.dart';

// ignore: camel_case_types
class cardHomePage extends StatelessWidget {
  const cardHomePage(
      {super.key, required this.title, required this.page, required this.icon});
  final String title;
  final Widget page;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: SizedBox(
      height: 60,
      child: TextButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => StatefulBuilder(
                    builder: (BuildContext context, setState) => page)));
          },
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Icon(
                icon,
                color: Colors.brown,
              ),
              const SizedBox(width: 20),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.brown,
                ),
              ),
            ],
          )),
    ));
  }
}
