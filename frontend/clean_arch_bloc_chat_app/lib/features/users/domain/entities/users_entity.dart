class UsersEntity {
  int? id;
  String? firstName;
  String? lastName;
  String? phone;
  String? imageUrl;
  String? lastOnline;
  String? status;
  List<Connections>? chats;

  UsersEntity({
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.imageUrl,
    this.lastOnline,
    this.status,
    this.chats,
  });
}

class Connections {
  int? id;
  String? firstName;
  String? lastName;
  String? phone;
  String? imageUrl;
  String? lastOnline;
  String? status;
  String? lastMessage;
  String? lastMessageTime;

  Connections({
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
}
