import 'package:clean_arch_bloc_chat_app/features/users/domain/entities/users_entity.dart';

class UsersModel {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? imageUrl;
  final String? lastOnline;
  final String? status;

  UsersModel({
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.imageUrl,
    this.lastOnline,
    this.status,
  });

  @override
  String toString() {
    return 'User{id: $id, firstName: $firstName, lastName: $lastName, phone: $phone}, imageUrl: $imageUrl, lastOnline: $lastOnline, status: $status';
  }

  factory UsersModel.fromEntity(UsersEntity userEntity) {
    return UsersModel(
      id: userEntity.id,
      firstName: userEntity.firstName,
      lastName: userEntity.lastName,
      phone: userEntity.phone,
      imageUrl: userEntity.imageUrl,
      lastOnline: userEntity.lastOnline,
      status: userEntity.status,
    );
  }

  UsersEntity toEntity() {
    return UsersEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      imageUrl: imageUrl,
      lastOnline: lastOnline,
      status: status,
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      "id": id,
      "firstName": firstName,
      "lastName": lastName,
      "phone": phone,
      "imageUrl": imageUrl,
      "lastOnline": lastOnline,
      "status": status,
    };
  }

  factory UsersModel.fromJson(Map<dynamic, dynamic> json) {
    return UsersModel(
      id: json["id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      phone: json["phone"],
      imageUrl: json["imageUrl"],
      lastOnline: json["lastOnline"],
      status: json["status"],
    );
  }
}
