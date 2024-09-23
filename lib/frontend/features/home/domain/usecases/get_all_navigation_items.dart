import 'package:clean_arch_bloc_chat_app/frontend/features/home/domain/entities/home_entity.dart';
import 'package:clean_arch_bloc_chat_app/frontend/features/home/domain/repositories/home_repository.dart';

class GetAllNavigationItems {
  final HomeRepository homeRepository;

  GetAllNavigationItems({required this.homeRepository});

  Future<List<HomeEntity>> call() async {
    return await homeRepository.getAllNavigationItems();
  }
}
