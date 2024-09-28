import 'package:clean_arch_bloc_chat_app/features/chats/domain/entities/chats_entity.dart';
import 'package:clean_arch_bloc_chat_app/features/users/domain/entities/users_entity.dart';

class ChatsModel {
  final UsersEntity? usersEntity;
  final String? chatsLastMessage;
  final DateTime? chatsLastMessageTime;

  ChatsModel({
    this.usersEntity,
    this.chatsLastMessage,
    this.chatsLastMessageTime,
  });

  factory ChatsModel.fromEntity(ChatsEntity chatsEntity) {
    return ChatsModel(
      usersEntity: chatsEntity.userEntity,
      chatsLastMessage: chatsEntity.chatsLastMessage,
      chatsLastMessageTime: chatsEntity.chatsLastMessageTime,
    );
  }

  ChatsEntity toEntity() {
    return ChatsEntity(
      userEntity: usersEntity,
      chatsLastMessage: chatsLastMessage,
      chatsLastMessageTime: chatsLastMessageTime,
    );
  }
}
