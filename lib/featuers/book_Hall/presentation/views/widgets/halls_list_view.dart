import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loc/featuers/book_Hall/data/models/hall_model.dart';
import 'package:loc/featuers/book_Hall/presentation/views/widgets/sent_request_buttom.dart';
import '../../../../../core/widgets/hall_list_view_loading_indecator.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/cubits/featch_avilable_halls/featch_avilable_halls_cubit.dart';
import 'hall_item.dart';

class HallsListView extends StatefulWidget {
  const HallsListView({
    Key? key,
    required this.startTime,
    required this.endTime,
    required this.selectedService,
  }) : super(key: key);

  final Timestamp startTime;
  final Timestamp endTime;
  final String selectedService;

  @override
  State<HallsListView> createState() => _HallsListViewState();
}

class _HallsListViewState extends State<HallsListView> {
  late Stream<QuerySnapshot<Object?>> _hallsStream;
  List<String> availableHallsIds = [];
  List<String> userhallsChoosed = [];
  List<String> choosedHallsNames = [];
  @override
  void initState() {
    super.initState();
    _hallsStream = FirebaseFirestore.instance.collection('locs').snapshots();
    BlocProvider.of<FeatchAvilableHallsCubit>(context).featchAvilableHallsDocs(
        startTime: widget.startTime, endTime: widget.endTime);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeatchAvilableHallsCubit, FeatchAvilableHallsState>(
      listener: (context, state) {
        if (state is FeatchAvilableHallsLoaded) {
          setState(() {
            availableHallsIds = state.availableHalls;
          });
        } else if (state is FeatchAvilableHallsError) {
          print(state.message);
        }
      },
      builder: (context, state) {
        if (state is ThereNoAvilableHalls) {
            return const HallListViewLoadingIndecator(
                scrollDirection: Axis.vertical,
              );
        }
        return StreamBuilder<QuerySnapshot<Object?>>(
          stream: _hallsStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(S.of(context).something_went_wrong);
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const HallListViewLoadingIndecator(
                scrollDirection: Axis.vertical,
              );
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
                          choosedHallsNames.add(filteredDocs[index]['name']);
                        } else {
                          userhallsChoosed
                              .removeAt(userhallsChoosed.indexOf(hallId));
                          choosedHallsNames
                              .removeAt(choosedHallsNames.indexOf(filteredDocs[index]['name']));
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
                  hallNames: choosedHallsNames,
                  startTime: widget.startTime,
                  endTime: widget.endTime,
                  hallsIds: userhallsChoosed,
                  selectedService: widget.selectedService)
            ]);
          },
        );
      },
    );
  }
}
