import 'package:loc/featuers/messages/data/models/chat_buble_model.dart';

import '../../domin/repos/message_repo.dart';
import '../data_source/local_data_source.dart';
import '../data_source/remote_data_source.dart';

class MessageRepoImpl implements MessageRepo {
  final MessagesRemoteDataSource remoteDataSource;
  final MessagesLocalDataSource localDataSource;

  MessageRepoImpl(
      {required this.remoteDataSource, required this.localDataSource});
  @override
  Future<List<ChatBubleModel>> getMessages()async {

    List<ChatBubleModel> messagesList;
    messagesList = localDataSource.getMessages();
    if (messagesList.isNotEmpty){
      print("this data comes from local data source======================");
      return messagesList;
    }else{
      messagesList =await remoteDataSource.getMessages();
      print("this data comes from remote data source======================");

      return messagesList;
    }
    
  }
}
