import 'package:clean_arch_bloc_chat_app/features/users/domain/entities/users_entity.dart';
import 'package:clean_arch_bloc_chat_app/features/users/domain/repositories/users_repository.dart';

class GetAllUsers {
  final UsersRepository? usersRepository;

  GetAllUsers({this.usersRepository});

  Future<List<UsersEntity>> call() {
    return usersRepository!.getAllUsers();
  }
}
