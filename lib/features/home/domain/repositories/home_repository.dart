import 'package:clean_arch_bloc_chat_app/features/home/domain/entities/home_entity.dart';

abstract class HomeRepository {
  Future<List<HomeEntity>> getAllNavigationItems();
}
