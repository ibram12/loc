import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loc/core/text_styles/Styles.dart';
import 'package:loc/featuers/admin/pressntation/widgets/reversations_table_body.dart';
import '../../../../generated/l10n.dart';


class ReservatoinTableView extends StatefulWidget {
  const ReservatoinTableView({super.key, required this.docId});
  final String docId;
  @override
  State<ReservatoinTableView> createState() => _ReservatoinTableViewState();
}

class _ReservatoinTableViewState extends State<ReservatoinTableView> {
  late Query reversations;
  late Stream<QuerySnapshot> stream;
  @override
  void initState() {
    super.initState();
    reversations = FirebaseFirestore.instance
        .collection('locs')
        .doc(widget.docId)
        .collection('reservations').orderBy('startTime', descending: true);
        stream = reversations.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
            stream: stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.data == null) {
                return  Center(child: Text(
                S.of(context).no_data_found
                ));
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    PaginatedDataTable(
                      columns:  [
                        DataColumn(label: Text(S.of(context).name)),
                        DataColumn(label: Text(S.of(context).service)),
                        DataColumn(label: Text(S.of(context).date)),
                        DataColumn(label: Text(S.of(context).start_time)),
                        DataColumn(label: Text(S.of(context).end_time)),
                        DataColumn(label: Text(S.of(context).delete)),
                      ],
                      rowsPerPage: 10,
                      header: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(Icons.arrow_back)),
                           Text(
                            S.of(context).reservations,
                            style: Styles.textStyle20,
                          ),
                        ],
                      ),
                      source: MyData(
                         context: context,
                        data: snapshot.data!.docs,
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
