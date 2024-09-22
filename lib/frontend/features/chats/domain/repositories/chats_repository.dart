import 'package:clean_arch_bloc_chat_app/frontend/features/chats/domain/entities/chats_entity.dart';

abstract class ChatsRepository {
  Future<List<ChatsEntity>> getAllChats();
}
