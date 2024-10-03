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
  });

  @override
  String toString() {
    return 'User{id: $id, firstName: $firstName, lastName: $lastName, phone: $phone}, imageUrl: $imageUrl, lastOnline: $lastOnline, status: $status, lastMessage: $lastMessage, lastMessageTime: $lastMessageTime';
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

    return data;
  }
}
