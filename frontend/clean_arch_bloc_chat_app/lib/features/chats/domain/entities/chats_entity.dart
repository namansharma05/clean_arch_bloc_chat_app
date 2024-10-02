import 'package:clean_arch_bloc_chat_app/features/users/domain/entities/users_entity.dart';

class ChatsEntity {
  final UsersEntity? userEntity;
  final String? chatsLastMessage;
  final DateTime? chatsLastMessageTime;

  ChatsEntity({
    this.userEntity,
    this.chatsLastMessage,
    this.chatsLastMessageTime,
  });
}
