import 'package:clean_arch_bloc_chat_app/features/users/domain/entities/users_entity.dart';

class UsersModel {
  final int? id;
  final String? name;
  final String? imageUrl;

  UsersModel({
    this.id,
    this.name,
    this.imageUrl,
  });

  factory UsersModel.fromEntity(UsersEntity userEntity) {
    return UsersModel(
      id: userEntity.id,
      name: userEntity.name,
      imageUrl: userEntity.imageUrl,
    );
  }

  UsersEntity toEntity() {
    return UsersEntity(
      id: id,
      name: name,
      imageUrl: imageUrl,
    );
  }
}
