import 'package:clean_arch_bloc_chat_app/features/individual_chat/domain/entities/individual_chat_message_entity.dart';

class IndividualChatMessageModel {
  int? senderId;
  int? receiverId;
  String? content;
  String? timeStamp;

  IndividualChatMessageModel({
    this.senderId,
    this.receiverId,
    this.content,
    this.timeStamp,
  });

  factory IndividualChatMessageModel.fromJson(Map<String, dynamic> json) {
    return IndividualChatMessageModel(
      senderId: json["senderId"],
      receiverId: json["receiverId"],
      content: json["content"],
      timeStamp: json["timeStamp"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "senderId": this.senderId,
      "receiverId": this.receiverId,
      "content": this.content,
      "timeStamp": this.timeStamp,
    };
  }

  factory IndividualChatMessageModel.fromEntity(
      IndividualChatMessageEntity chatEntity) {
    return IndividualChatMessageModel(
      senderId: chatEntity.senderId,
      receiverId: chatEntity.receiverId,
      content: chatEntity.content,
      timeStamp: chatEntity.timeStamp,
    );
  }

  IndividualChatMessageEntity toEntity() {
    return IndividualChatMessageEntity(
      senderId: this.senderId,
      receiverId: this.receiverId,
      content: this.content,
      timeStamp: this.timeStamp,
    );
  }

  IndividualChatMessageEntity jsonToEntity(Map<String, dynamic> json) {
    print('inside individual chat message model json to entity');
    return IndividualChatMessageEntity(
      senderId: json["senderId"],
      receiverId: json["receiverId"],
      content: json["content"],
      timeStamp: json["timeStamp"],
    );
  }
}
