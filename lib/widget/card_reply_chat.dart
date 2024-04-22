// import 'package:flutter/material.dart';
// import 'package:pdf_reader_app/chat/chat.dart';
//
// class CardReplyChat extends StatelessWidget {
//   const CardReplyChat({super.key, required this.mass, required this.email});
//   final String email;
//   final String mass;
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         print(mass);
//         Navigator.of(context).push(MaterialPageRoute(
//             builder: (BuildContext context) => StatefulBuilder(
//                 builder: (BuildContext context, setState) =>
//                     roverChat(email1: mass))));
//       },
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         decoration: const BoxDecoration(
//           borderRadius: BorderRadius.only(
//             topRight: Radius.circular(32),
//             topLeft: Radius.circular(32),
//             bottomRight: Radius.circular(32),
//           ),
//           color: Colors.amber,
//         ),
//         child: Text(
//           mass,
//           style: const TextStyle(color: Colors.white),
//         ),
//       ),
//     );
//   }
// }
