import 'package:clean_arch_bloc_chat_app/features/individual_chat/data/models/individual_chat_message_model.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/domain/entities/individual_chat_message_entity.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/domain/respsitories/individual_chat_message_repository.dart';

class IndividualChatMessageRepositoryImpl
    implements IndividualChatMessageRepository {
  List<IndividualChatMessageModel> chatMessages = [
    IndividualChatMessageModel(
      type: "Source",
      message: 'Hi',
      messageTime: DateTime.now(),
    ),
    IndividualChatMessageModel(
      type: "Target",
      message: 'Hello',
      messageTime: DateTime.now(),
    ),
    IndividualChatMessageModel(
      type: "Source",
      message: 'How are you?',
      messageTime: DateTime.now(),
    ),
    IndividualChatMessageModel(
      type: "Target",
      message: 'I am fine. How are you?',
      messageTime: DateTime.now(),
    ),
    IndividualChatMessageModel(
      type: "Source",
      message: 'I am also fine.',
      messageTime: DateTime.now(),
    ),
  ];
  @override
  Future<List<IndividualChatMessageEntity>> getAllChatMessages() async {
    final result = chatMessages
        .map((individualChatMessage) => individualChatMessage.toEntity())
        .toList();
    return result;
  }

  @override
  Future<void> addNewChatMessage(
      IndividualChatMessageEntity? newChatMessage) async {
    chatMessages.add(IndividualChatMessageModel.fromEntity(newChatMessage!));
  }
}
