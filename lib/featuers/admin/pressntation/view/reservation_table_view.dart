import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loc/core/text_styles/Styles.dart';
import 'package:loc/featuers/admin/pressntation/widgets/reversations_table_body.dart';

class ReservatoinTableView extends StatefulWidget {
  const ReservatoinTableView({super.key, required this.docId});
  final String docId;
  @override
  State<ReservatoinTableView> createState() => _ReservatoinTableViewState();
}

class _ReservatoinTableViewState extends State<ReservatoinTableView> {
  late Query reversations;
  @override
  void initState() {
    super.initState();
    reversations = FirebaseFirestore.instance
        .collection('locs')
        .doc(widget.docId)
        .collection('reservations').orderBy('startTime', descending: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: reversations.get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.data == null) {
              return const Center(child: Text('No Data Found'));
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  PaginatedDataTable(
                    columns: const [
                      DataColumn(label: Text('name')),
                      DataColumn(label: Text('date')),
                      DataColumn(label: Text('start time')),
                      DataColumn(label: Text('end time')),
                    ],
                    rowsPerPage: 10,
                    header: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.arrow_back)),
                        const Text(
                          'reservations',
                          style: Styles.textStyle20,
                        ),
                      ],
                    ),
                    source: MyData(
                      data: snapshot.data!.docs,
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
