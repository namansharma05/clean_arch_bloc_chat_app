import 'package:clean_arch_bloc_chat_app/features/users/data/models/users_model.dart';
import 'package:clean_arch_bloc_chat_app/features/users/domain/entities/users_entity.dart';
import 'package:clean_arch_bloc_chat_app/features/users/domain/repositories/users_repository.dart';

class UsersRepositoryImpl implements UsersRepository {
  final List<UsersModel> usersModel = [
    UsersModel(id: 1, name: "john", imageUrl: "/image url 1"),
    UsersModel(id: 2, name: "ray", imageUrl: "/image url 2"),
    UsersModel(id: 3, name: "cena", imageUrl: "/image url 3"),
    UsersModel(id: 4, name: "rick", imageUrl: "/image url 4"),
  ];
  @override
  Future<List<UsersEntity>> getAllUsers() async {
    final result = usersModel.map((userModel) => userModel.toEntity()).toList();
    return result;
  }
}
