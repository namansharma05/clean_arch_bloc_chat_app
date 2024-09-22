import 'package:clean_arch_bloc_chat_app/frontend/features/chats/domain/entities/chats_entity.dart';

class ChatsModel extends ChatsEntity {
  ChatsModel({
    required super.chatsId,
    required super.chatsTitle,
    required super.chatsLastMessage,
    required super.chatsLastMessageTime,
  });
}
