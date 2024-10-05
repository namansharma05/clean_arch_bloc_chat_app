class ChatsEntity {
  int? id;
  String? firstName;
  String? lastName;
  String? phone;
  String? imageUrl;
  String? lastOnline;
  String? status;
  String? lastMessage;
  String? lastMessageTime;
  List<MessagesEntity>? messages;

  ChatsEntity({
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.imageUrl,
    this.lastOnline,
    this.status,
    this.lastMessage,
    this.lastMessageTime,
    this.messages,
  });
}

class MessagesEntity {
  int? senderId;
  int? receiverId;
  String? content;
  String? timeStamp;

  MessagesEntity({
    this.senderId,
    this.receiverId,
    this.content,
    this.timeStamp,
  });
}
