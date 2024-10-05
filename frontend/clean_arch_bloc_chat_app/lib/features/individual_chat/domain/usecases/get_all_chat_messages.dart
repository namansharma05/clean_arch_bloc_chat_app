import 'package:clean_arch_bloc_chat_app/features/individual_chat/domain/entities/individual_chat_message_entity.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/domain/respsitories/individual_chat_message_repository.dart';

class GetAllChatMessages {
  final IndividualChatMessageRepository individualChatMessageRepository;

  GetAllChatMessages({required this.individualChatMessageRepository});

  Future<List<IndividualChatMessageEntity>> call(
      int? userId, int? chatId) async {
    return await individualChatMessageRepository.getAllChatMessages(
        userId, chatId);
  }
}
