import 'package:clean_arch_bloc_chat_app/features/home/domain/entities/home_entity.dart';
import 'package:clean_arch_bloc_chat_app/features/users/domain/entities/users_entity.dart';

abstract class HomeRepository {
  Future<List<HomeEntity>> getAllNavigationItems(UsersEntity user);
}
