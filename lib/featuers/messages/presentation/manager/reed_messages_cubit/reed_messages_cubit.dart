import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'reed_messages_state.dart';

class ReedMessagesCubit extends Cubit<ReedMessagesState> {
  ReedMessagesCubit() : super(ReedMessagesInitial());
}
