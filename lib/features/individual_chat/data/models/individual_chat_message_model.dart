import 'package:clean_arch_bloc_chat_app/features/individual_chat/domain/entities/individual_chat_message_entity.dart';

class IndividualChatMessageModel {
  final String? type;
  final String? message;
  final DateTime? messageTime;

  IndividualChatMessageModel({
    this.type,
    this.message,
    this.messageTime,
  });

  factory IndividualChatMessageModel.fromJson(Map<String, dynamic> json) {
    return IndividualChatMessageModel(
      type: json['type'],
      message: json['message'],
      messageTime: json['messageTime'],
    );
  }

  factory IndividualChatMessageModel.fromEntity(
      IndividualChatMessageEntity chatEntity) {
    return IndividualChatMessageModel(
      type: chatEntity.type,
      message: chatEntity.message,
      messageTime: chatEntity.messageTime,
    );
  }

  IndividualChatMessageEntity toEntity() {
    return IndividualChatMessageEntity(
      type: type!,
      message: message!,
      messageTime: messageTime!,
    );
  }

  IndividualChatMessageEntity jsonToEntity(Map<String, dynamic> json) {
    print('inside individual chat message model json to entity');
    return IndividualChatMessageEntity(
      type: json['type'],
      message: json['message'],
      messageTime: DateTime.parse(json['messageTime']),
    );
  }
}
