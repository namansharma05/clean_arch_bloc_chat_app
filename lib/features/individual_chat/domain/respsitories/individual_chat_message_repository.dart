import 'package:clean_arch_bloc_chat_app/features/individual_chat/domain/entities/individual_chat_message_entity.dart';

abstract class IndividualChatMessageRepository {
  Future<List<IndividualChatMessageEntity>> getAllChatMessages();
  Future<void> addNewChatMessage(IndividualChatMessageEntity newChatMessage);
}
