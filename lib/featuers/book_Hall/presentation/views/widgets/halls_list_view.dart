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
  late Stream<List<QueryDocumentSnapshot>> _hallsStream = Stream.value([]);
  List<String> hallsIds = [];
  @override
  void initState() {
    super.initState();
    _fetchAvailableHalls();
  }

  void _fetchAvailableHalls() {
    final cubit = BlocProvider.of<FeatchAvilableHallsCubit>(context);
    cubit
        .getAvilableHalls(
      startTime: widget.startTime,
      endTime: widget.endTime,
    )
        .then((availableHalls) {
      setState(() {
        _hallsStream = Stream.value(availableHalls);
      });
    }).catchError((error) {
      setState(() {
        _hallsStream = Stream.error(error);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<QueryDocumentSnapshot>>(
      stream: _hallsStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return Stack(alignment: Alignment.bottomCenter, children: [
          GridView.builder(
            itemCount: snapshot.data!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              return HallItem(
                selectedHalls: hallsIds,
                onSelectionChanged: (isSelected, hallId) {
                  setState(() {
                    if (isSelected) {
                      hallsIds.add(hallId);
                    } else {
                      hallsIds.removeAt(hallsIds.indexOf(hallId));
                    }
                  });
                },
                hallId: snapshot.data![index].id,
                hallModel: HallModel.fromJson(
                    snapshot.data![index].data() as Map<String, dynamic>,0),
              );
            },
          ),
          SentRequestButtom(
            startTime: widget.startTime,
            endTime: widget.endTime,
            hallsIds: hallsIds,
          )
        ]);
      },
    );
  }
}
