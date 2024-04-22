// import 'package:flutter/material.dart';
//
// import '../afham aloom/part.dart';
// import '../screen/Sign/Sign_Up.dart';
//
// class cardPart extends StatelessWidget {
//   cardPart({
//     super.key,
//     required this.part,
//   });
//   Part part;
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//         child: SizedBox(
//       height: 50,
//       child: TextButton(
//           onPressed: () {
//             Navigator.of(context).push(MaterialPageRoute(
//                 builder: (BuildContext context) => StatefulBuilder(
//                     builder: (BuildContext context, setState) => const SignUP())));
//           },
//           child: Row(
//             children: [
//               const SizedBox(
//                 width: 10,
//               ),
//               const Icon(
//                 Icons.domain_verification,
//                 color: Colors.brown,
//                 size: 18,
//               ),
//               const SizedBox(width: 20),
//               Text(
//                 part.text,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                   color: Colors.brown,
//                 ),
//               ),
//             ],
//           )),
//     ));
//   }
// }
