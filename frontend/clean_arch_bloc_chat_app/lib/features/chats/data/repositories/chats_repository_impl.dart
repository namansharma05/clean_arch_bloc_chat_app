import 'dart:async';

import 'package:clean_arch_bloc_chat_app/features/chats/data/models/chats_model.dart';
import 'package:clean_arch_bloc_chat_app/features/chats/domain/entities/chats_entity.dart';
import 'package:clean_arch_bloc_chat_app/features/chats/domain/repositories/chats_repository.dart';
import 'package:clean_arch_bloc_chat_app/features/users/domain/entities/users_entity.dart';

class ChatsRepositoryImpl implements ChatsRepository {
  List<ChatsModel> dummyChatsData = [
    ChatsModel(
      usersEntity: UsersEntity(),
      chatsLastMessage: 'Hi there, how are you',
      chatsLastMessageTime: DateTime(2024, 9, 10),
    ),
    ChatsModel(
      usersEntity: UsersEntity(),
      chatsLastMessage: 'Hello are you ready',
      chatsLastMessageTime: DateTime(2024, 9, 20),
    ),
    ChatsModel(
      usersEntity: UsersEntity(),
      chatsLastMessage: 'app is in progress',
      chatsLastMessageTime: DateTime(2024, 9, 18),
    ),
    ChatsModel(
      usersEntity: UsersEntity(),
      chatsLastMessage: 'everything is hardcoded!',
      chatsLastMessageTime: DateTime(2024, 9, 9),
    ),
  ];
  @override
  Future<List<ChatsEntity>> getAllChats() async {
    final result =
        dummyChatsData.map((chatData) => chatData.toEntity()).toList();
    return result;
  }
}
