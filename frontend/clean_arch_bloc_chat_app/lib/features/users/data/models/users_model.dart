import 'package:clean_arch_bloc_chat_app/features/users/domain/entities/users_entity.dart';

class UsersModel {
  int? id;
  String? firstName;
  String? lastName;
  String? phone;
  String? imageUrl;
  String? lastOnline;
  String? status;
  List<Chats>? chats;

  UsersModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.phone,
      this.imageUrl,
      this.lastOnline,
      this.status,
      this.chats});

  UsersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
    imageUrl = json['imageUrl'];
    lastOnline = json['lastOnline'];
    status = json['status'];
    if (json['chats'] != null) {
      chats = <Chats>[];
      json['chats'].forEach((v) {
        chats!.add(new Chats.fromJson(v));
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
    if (this.chats != null) {
      data['chats'] = this.chats!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'User{id: $id, firstName: $firstName, lastName: $lastName, phone: $phone}, imageUrl: $imageUrl, lastOnline: $lastOnline, status: $status, chats: $chats';
  }

  UsersModel.fromEntity(UsersEntity userEntity) {
    final data = new UsersModel();
    data.id = userEntity.id;
    data.firstName = userEntity.firstName;
    data.lastName = userEntity.lastName;
    data.phone = userEntity.phone;
    data.imageUrl = userEntity.imageUrl;
    data.lastOnline = userEntity.lastOnline;
    data.status = userEntity.status;
    if (userEntity.chats != null) {
      chats = <Chats>[];
      userEntity.chats!.forEach((v) {
        chats!.add(Chats.fromConnectionsEntity(v));
      });
    }
  }

  UsersEntity toEntity() {
    final UsersEntity data = new UsersEntity();
    data.id = this.id;
    data.firstName = this.firstName;
    data.lastName = this.lastName;
    data.phone = this.phone;
    data.imageUrl = this.imageUrl;
    data.lastOnline = this.lastOnline;
    data.status = this.status;
    if (this.chats != null) {
      data.chats = this.chats!.map((v) => v.toConnectionsEntity()).toList();
    }
    return data;
  }
}

class Chats {
  int? id;
  String? firstName;
  String? lastName;
  String? phone;
  String? imageUrl;
  String? lastOnline;
  String? status;
  String? lastMessage;
  String? lastMessageTime;

  Chats({
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

  Chats.fromJson(Map<String, dynamic> json) {
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

  Chats.fromConnectionsEntity(Connections connectionsEntity) {
    Chats(
      id: connectionsEntity.id,
      firstName: connectionsEntity.firstName,
      lastName: connectionsEntity.lastName,
      phone: connectionsEntity.phone,
      imageUrl: connectionsEntity.imageUrl,
      lastOnline: connectionsEntity.lastOnline,
      status: connectionsEntity.status,
      lastMessage: connectionsEntity.lastMessage,
      lastMessageTime: connectionsEntity.lastMessageTime,
    );
  }

  Connections toConnectionsEntity() {
    return Connections(
      id: id,
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      imageUrl: imageUrl,
      lastOnline: lastOnline,
      status: status,
      lastMessage: lastMessage,
      lastMessageTime: lastMessageTime,
    );
  }
}
