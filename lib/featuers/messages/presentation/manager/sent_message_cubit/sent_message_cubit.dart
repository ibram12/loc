import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'sent_message_state.dart';

class SentMessageCubit extends Cubit<SentMessageState> {
  SentMessageCubit() : super(SentMessageInitial());
  
}
