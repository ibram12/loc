// import 'package:flutter/material.dart';
// import '../screen/links.dart';
// // ignore: depend_on_referenced_packages
// import 'package:url_launcher/url_launcher.dart';
//
// // ignore: camel_case_types
// class cardDrawer extends StatelessWidget {
//   const cardDrawer({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: SafeArea(
//         child: Column(
//           children: [
//             Container(
//               padding: const EdgeInsets.only(
//                 top: 20,
//                 bottom: 30,
//               ),
//               color: Colors.amber,
//               child: const Center(
//                 child: CircleAvatar(
//                   backgroundColor: Colors.amber,
//                   radius: 70.0,
//                   backgroundImage: AssetImage("images/2022.png"),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: ListView.builder(
//                   itemCount: links.length,
//                   itemBuilder: ((context, index) {
//                     return Container(
//                       padding:
//                           const EdgeInsets.only(top: 10, left: 20, right: 20),
//                       height: 70,
//                       child: Row(
//                         children: [
//                           const Icon(
//                             Icons.link,
//                             color: Colors.brown,
//                           ),
//                           const SizedBox(width: 0),
//                           TextButton(
//                             onPressed: () async {
//                               if (!await launchUrl(
//                                 Uri(
//                                     scheme: links[index].scheme,
//                                     host: links[index].host,
//                                     path: links[index].path),
//                                 mode: LaunchMode.externalApplication,
//                                 webViewConfiguration:
//                                     const WebViewConfiguration(
//                                         enableJavaScript: false),
//                               )) {
//                                 throw 'Could not launch $Uri';
//                               }
//                             },
//                             child: Text(
//                               links[index].name,
//                               style: const TextStyle(
//                                   fontSize: 18, color: Colors.brown),
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   })),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
