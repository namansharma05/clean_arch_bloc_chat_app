import 'package:clean_arch_bloc_chat_app/frontend/features/chats/data/models/chats_model.dart';
import 'package:clean_arch_bloc_chat_app/frontend/features/chats/domain/repositories/chats_repository.dart';

class ChatsRepositoryImpl implements ChatsRepository {
  List<ChatsModel> dummyChatsData = [
    ChatsModel(
      chatsId: 1,
      chatsTitle: 'Ramesh',
      chatsLastMessage: 'Hi there, how are you',
      chatsLastMessageTime: DateTime(2024, 9, 10),
    ),
    ChatsModel(
      chatsId: 2,
      chatsTitle: 'Suresh',
      chatsLastMessage: 'Hello are you ready',
      chatsLastMessageTime: DateTime(2024, 9, 20),
    ),
    ChatsModel(
      chatsId: 1,
      chatsTitle: 'kishor',
      chatsLastMessage: 'app is in progress',
      chatsLastMessageTime: DateTime(2024, 9, 18),
    ),
  ];
  @override
  Future<List<ChatsModel>> getAllChats() async {
    return dummyChatsData;
  }
}
