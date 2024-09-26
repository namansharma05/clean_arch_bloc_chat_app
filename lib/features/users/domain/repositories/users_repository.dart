import 'package:clean_arch_bloc_chat_app/features/users/domain/entities/users_entity.dart';

abstract class UsersRepository {
  Future<List<UsersEntity>> getAllUsers();
}
