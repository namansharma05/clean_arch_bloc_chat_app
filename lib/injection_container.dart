import 'package:clean_arch_bloc_chat_app/frontend/features/chats/data/repositories/chats_repository_impl.dart';
import 'package:clean_arch_bloc_chat_app/frontend/features/chats/domain/repositories/chats_repository.dart';
import 'package:clean_arch_bloc_chat_app/frontend/features/chats/domain/usecases/get_all_chats.dart';
import 'package:clean_arch_bloc_chat_app/frontend/features/chats/presentation/bloc/chats_bloc.dart';
import 'package:clean_arch_bloc_chat_app/frontend/features/home/data/repositories/home_repository_impl.dart';
import 'package:clean_arch_bloc_chat_app/frontend/features/home/domain/repositories/home_repository.dart';
import 'package:clean_arch_bloc_chat_app/frontend/features/home/domain/usecases/get_all_navigation_items.dart';
import 'package:clean_arch_bloc_chat_app/frontend/features/home/presentation/bloc/home_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void init() {
  // repositories
  getIt.registerLazySingleton<ChatsRepository>(() => ChatsRepositoryImpl());
  getIt.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl());

  // usecases
  getIt.registerLazySingleton<GetAllChats>(
      () => GetAllChats(chatsRepository: getIt()));

  getIt.registerLazySingleton<GetAllNavigationItems>(
      () => GetAllNavigationItems(homeRepository: getIt()));

  // bloc
  getIt.registerFactory(() => ChatsBloc(getIt()));
  getIt.registerFactory(() => HomeBloc(getIt()));
}
