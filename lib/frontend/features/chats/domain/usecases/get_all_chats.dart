import 'package:clean_arch_bloc_chat_app/frontend/features/chats/domain/entities/chats_entity.dart';
import 'package:clean_arch_bloc_chat_app/frontend/features/chats/domain/repositories/chats_repository.dart';

class GetAllChats {
  final ChatsRepository chatsRepository;

  GetAllChats({required this.chatsRepository});

  Future<List<ChatsEntity>> call() {
    return chatsRepository.getAllChats();
  }
}
