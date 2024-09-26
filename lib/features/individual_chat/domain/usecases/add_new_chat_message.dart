import 'package:clean_arch_bloc_chat_app/features/individual_chat/domain/entities/individual_chat_message_entity.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/domain/respsitories/individual_chat_message_repository.dart';

class AddNewChatMessage {
  final IndividualChatMessageRepository? individualChatMessageRepository;

  AddNewChatMessage({this.individualChatMessageRepository});

  Future<void> call(IndividualChatMessageEntity? newChatMessage) async {
    await individualChatMessageRepository!.addNewChatMessage(newChatMessage!);
  }
}
