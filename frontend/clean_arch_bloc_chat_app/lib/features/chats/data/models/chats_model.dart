import 'package:clean_arch_bloc_chat_app/features/chats/domain/entities/chats_entity.dart';

class ChatsModel {
  int? id;
  String? firstName;
  String? lastName;
  String? phone;
  String? imageUrl;
  String? lastOnline;
  String? status;
  String? lastMessage;
  String? lastMessageTime;
  List<Messages>? messages;

  ChatsModel({
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

  @override
  String toString() {
    return 'User{id: $id, firstName: $firstName, lastName: $lastName, phone: $phone}, imageUrl: $imageUrl, lastOnline: $lastOnline, status: $status, lastMessage: $lastMessage, lastMessageTime: $lastMessageTime, messages: $messages';
  }

  ChatsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
    imageUrl = json['imageUrl'];
    lastOnline = json['lastOnline'];
    status = json['status'];
    lastMessage = json['lastMessage'];
    lastMessageTime = json['lastMessageTime'];
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['phone'] = this.phone;
    data['imageUrl'] = this.imageUrl;
    data['lastOnline'] = this.lastOnline;
    data['status'] = this.status;
    data['lastMessage'] = this.lastMessage;
    data['lastMessageTime'] = this.lastMessageTime;
    if (this.messages != null) {
      data['messages'] = this.messages!.map((e) => e.toJson()).toList();
    }
    return data;
  }

  ChatsModel.fromEntity(ChatsEntity chatsEntity) {
    final data = new ChatsModel();
    data.id = chatsEntity.id;
    data.firstName = chatsEntity.firstName;
    data.lastName = chatsEntity.lastName;
    data.phone = chatsEntity.phone;
    data.imageUrl = chatsEntity.imageUrl;
    data.lastOnline = chatsEntity.lastOnline;
    data.status = chatsEntity.status;
    data.lastMessage = chatsEntity.lastMessage;
    data.lastMessageTime = chatsEntity.lastMessageTime;
    if (chatsEntity.messages != null) {
      messages = <Messages>[];
      chatsEntity.messages!.forEach((v) {
        messages!.add(Messages.fromMessagesEntity(v));
      });
    }
  }

  ChatsEntity toEntity() {
    final ChatsEntity data = new ChatsEntity();
    data.id = this.id;
    data.firstName = this.firstName;
    data.lastName = this.lastName;
    data.phone = this.phone;
    data.imageUrl = this.imageUrl;
    data.lastOnline = this.lastOnline;
    data.status = this.status;
    data.lastMessage = this.lastMessage;
    data.lastMessageTime = this.lastMessageTime;
    if (this.messages != null) {
      data.messages = this.messages!.map((e) => e.toMessagesEntity()).toList();
    }
    return data;
  }
}

class Messages {
  int? senderId;
  int? receiverId;
  String? content;
  String? timeStamp;

  Messages({
    this.senderId,
    this.receiverId,
    this.content,
    this.timeStamp,
  });

  factory Messages.fromJson(Map<String, dynamic> json) {
    return Messages(
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

  factory Messages.fromMessagesEntity(MessagesEntity msg) {
    return Messages(
      senderId: msg.senderId,
      receiverId: msg.receiverId,
      content: msg.content,
      timeStamp: msg.timeStamp,
    );
  }

  MessagesEntity toMessagesEntity() {
    return MessagesEntity(
      senderId: this.senderId,
      receiverId: this.receiverId,
      content: this.content,
      timeStamp: this.timeStamp,
    );
  }
}
