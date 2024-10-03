import 'package:clean_arch_bloc_chat_app/features/home/domain/entities/home_entity.dart';
import 'package:clean_arch_bloc_chat_app/features/home/domain/repositories/home_repository.dart';
import 'package:clean_arch_bloc_chat_app/features/users/domain/entities/users_entity.dart';

class GetAllNavigationItems {
  final HomeRepository homeRepository;

  GetAllNavigationItems({required this.homeRepository});

  Future<List<HomeEntity>> call(UsersEntity user) async {
    return await homeRepository.getAllNavigationItems(user);
  }
}
