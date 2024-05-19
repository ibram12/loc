import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/featuers/book_Hall/data/models/hall_model.dart';
import 'package:loc/featuers/book_Hall/presentation/views/widgets/sent_request_buttom.dart';
import '../../manager/cubits/featch_avilable_halls/featch_avilable_halls_cubit.dart';
import 'hall_item.dart';

class HallsListView extends StatefulWidget {
  const HallsListView({
    Key? key,
    required this.startTime,
    required this.endTime,
  }) : super(key: key);

  final Timestamp startTime;
  final Timestamp endTime;

  @override
  State<HallsListView> createState() => _HallsListViewState();
}

class _HallsListViewState extends State<HallsListView> {
  late Stream<QuerySnapshot<Object?>> _hallsStream;
  List<String> availableHallsIds = [];
  List<String> userhallsChoosed = [];
  @override
  void initState() {
    super.initState();
    _hallsStream = FirebaseFirestore.instance.collection('locs').snapshots();
    BlocProvider.of<FeatchAvilableHallsCubit>(context).featchAvilableHallsDocs(
        startTime: widget.startTime, endTime: widget.endTime);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FeatchAvilableHallsCubit, FeatchAvilableHallsState>(
      listener: (context, state) {
        if (state is FeatchAvilableHallsLoaded) {
          setState(() {
            availableHallsIds = state.availableHalls;
          });
        } else if (state is FeatchAvilableHallsError) {
          print(state.message);
        }
      },
      child: StreamBuilder<QuerySnapshot<Object?>>(
        stream: _hallsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Text('No data available');
          }
          var filteredDocs = snapshot.data!.docs
              .where((doc) => availableHallsIds.contains(doc.id))
              .toList();
          return Stack(alignment: Alignment.bottomCenter, children: [
            GridView.builder(
              itemCount: filteredDocs.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                return HallItem(
                  selectedHalls: userhallsChoosed,
                  onSelectionChanged: (isSelected, hallId) {
                    setState(() {
                      if (isSelected) {
                        userhallsChoosed.add(hallId);
                      } else {
                        userhallsChoosed
                            .removeAt(userhallsChoosed.indexOf(hallId));
                      }
                    });
                  },
                  hallId: filteredDocs[index].id,
                  hallModel: HallModel.fromJson(
                      filteredDocs[index].data() as Map<String, dynamic>),
                );
              },
            ),
            SentRequestButtom(
              startTime: widget.startTime,
              endTime: widget.endTime,
              hallsIds: userhallsChoosed,
            )
          ]);
        },
      ),
    );
  }
}
