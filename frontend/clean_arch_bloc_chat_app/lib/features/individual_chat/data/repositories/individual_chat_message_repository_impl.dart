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
    final result = chatMessages.map((individualChatMessage) {
      // print(individualChatMessage.runtimeType);
      print('individual chat message type is: ${individualChatMessage.type}');
      print('individual chat message is: ${individualChatMessage.message}');
      print(
          'individual chat messagetime is: ${individualChatMessage.messageTime}');
      return individualChatMessage.toEntity();
    }).toList();
    return result;
  }

  @override
  Future<void> addNewChatMessage(
      IndividualChatMessageEntity? newChatMessage) async {
    print('inside add new chat message');
    chatMessages.add(IndividualChatMessageModel.fromEntity(newChatMessage!));
    chatMessages.forEach(print);
  }
}
