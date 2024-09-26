import 'package:clean_arch_bloc_chat_app/features/chats/data/repositories/chats_repository_impl.dart';
import 'package:clean_arch_bloc_chat_app/features/chats/domain/repositories/chats_repository.dart';
import 'package:clean_arch_bloc_chat_app/features/chats/domain/usecases/get_all_chats.dart';
import 'package:clean_arch_bloc_chat_app/features/chats/presentation/bloc/chats_bloc.dart';
import 'package:clean_arch_bloc_chat_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:clean_arch_bloc_chat_app/features/home/domain/repositories/home_repository.dart';
import 'package:clean_arch_bloc_chat_app/features/home/domain/usecases/get_all_navigation_items.dart';
import 'package:clean_arch_bloc_chat_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/data/repositories/individual_chat_message_repository_impl.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/domain/respsitories/individual_chat_message_repository.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/domain/usecases/add_new_chat_message.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/domain/usecases/get_all_chat_messages.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/presentation/bloc/individual_chat_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void init() {
  // repositories
  getIt.registerLazySingleton<ChatsRepository>(() => ChatsRepositoryImpl());
  getIt.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl());
  getIt.registerLazySingleton<IndividualChatMessageRepository>(
      () => IndividualChatMessageRepositoryImpl());

  // usecases
  getIt.registerLazySingleton<GetAllChats>(
      () => GetAllChats(chatsRepository: getIt()));
  getIt.registerLazySingleton<GetAllNavigationItems>(
      () => GetAllNavigationItems(homeRepository: getIt()));
  getIt.registerLazySingleton(
      () => GetAllChatMessages(individualChatMessageRepository: getIt()));
  getIt.registerLazySingleton(
      () => AddNewChatMessage(individualChatMessageRepository: getIt()));

  // bloc
  getIt.registerFactory(() => ChatsBloc(getIt()));
  getIt.registerFactory(() => HomeBloc(getIt()));
  getIt.registerFactory(() => IndividualChatBloc(getIt(), getIt()));
}
