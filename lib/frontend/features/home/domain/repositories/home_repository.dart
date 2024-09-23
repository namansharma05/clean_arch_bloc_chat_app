import 'package:clean_arch_bloc_chat_app/frontend/features/home/domain/entities/home_entity.dart';

abstract class HomeRepository {
  Future<List<HomeEntity>> getAllNavigationItems();
}
