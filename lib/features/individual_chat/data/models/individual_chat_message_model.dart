import 'package:clean_arch_bloc_chat_app/features/individual_chat/domain/entities/individual_chat_message_entity.dart';

class IndividualChatMessageModel {
  final bool? fromMe;
  final String? message;
  final DateTime? messageTime;

  IndividualChatMessageModel({
    this.fromMe,
    this.message,
    this.messageTime,
  });

  factory IndividualChatMessageModel.fromEntity(
      IndividualChatMessageEntity chatEntity) {
    return IndividualChatMessageModel(
      fromMe: chatEntity.fromMe,
      message: chatEntity.message,
      messageTime: chatEntity.messageTime,
    );
  }

  IndividualChatMessageEntity toEntity() {
    return IndividualChatMessageEntity(
      fromMe: fromMe!,
      message: message!,
      messageTime: messageTime!,
    );
  }
}
