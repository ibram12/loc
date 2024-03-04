import 'package:flutter/material.dart';

class customCardChat extends StatelessWidget {
  const customCardChat({super.key, required this.mass});

  final String mass;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(32),
            topLeft: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
          color: Colors.amber,
        ),
        child: Text(
          mass,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class customCardChatfri extends StatelessWidget {
  const customCardChatfri({super.key, required this.mass});

  final String mass;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(32),
            topLeft: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
          color: Colors.brown,
        ),
        child: Text(
          mass,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
