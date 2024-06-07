// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:loc/featuers/admin/pressntation/widgets/custom_divider.dart';
// import 'package:loc/featuers/admin/pressntation/widgets/request_item.dart';

// import '../../data/models/request_model.dart';

// class AllRequestsViewBody extends StatelessWidget {
//   const AllRequestsViewBody({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return CustomScrollView(slivers: [
//       SliverToBoxAdapter(
//         child: Column(children: <Widget>[
//           const CustomDiveder(hallName: 'Hall 1'),
//           ListView.builder(
//             physics: const NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//               itemCount: 6,
//               itemBuilder: (context, index) {
//                 return RequestItem(
//                     requestModel: RequestModel(
//                         imageUrl: '', 
//                       service: '',
//                       hallId: '',
//                         name: 'Ahmed',
//                         sendDate: '2022-10-20',
//                         replyState: ReplyState.noReplyYet,
//                         startTime: Timestamp.fromDate(DateTime.now()),
//                         endTime: Timestamp.fromDate(DateTime.now()),
//                         id: 'id',
//                         daily: true,
//                         requestId: ''),
//                     reservationId: '',
//                     hallId: '',
//                     hallName: 'ramy');
//               })
//         ]),
//       )
//     ]);
//   }
// }
