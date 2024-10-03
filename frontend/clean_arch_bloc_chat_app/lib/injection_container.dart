import 'package:clean_arch_bloc_chat_app/features/chats/data/repositories/chats_repository_impl.dart';
import 'package:clean_arch_bloc_chat_app/features/chats/domain/repositories/chats_repository.dart';
import 'package:clean_arch_bloc_chat_app/features/chats/domain/usecases/get_all_chats.dart';
import 'package:clean_arch_bloc_chat_app/features/chats/presentation/bloc/chats_bloc.dart';
import 'package:clean_arch_bloc_chat_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:clean_arch_bloc_chat_app/features/home/domain/repositories/home_repository.dart';
import 'package:clean_arch_bloc_chat_app/features/home/domain/usecases/get_all_navigation_items.dart';
import 'package:clean_arch_bloc_chat_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/data/models/individual_chat_message_model.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/data/repositories/individual_chat_message_repository_impl.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/domain/respsitories/individual_chat_message_repository.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/domain/usecases/add_new_chat_message.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/domain/usecases/get_all_chat_messages.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/presentation/bloc/individual_chat_bloc.dart';
import 'package:clean_arch_bloc_chat_app/features/users/data/repositories/users_repository_impl.dart';
import 'package:clean_arch_bloc_chat_app/features/users/domain/repositories/users_repository.dart';
import 'package:clean_arch_bloc_chat_app/features/users/domain/usecases/get_all_users.dart';
import 'package:clean_arch_bloc_chat_app/features/users/presentation/bloc/users_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void init() {
  // models
  getIt.registerLazySingleton<IndividualChatMessageModel>(
      () => IndividualChatMessageModel());

  // repositories
  getIt.registerLazySingleton<ChatsRepository>(() => ChatsRepositoryImpl());
  getIt.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl());
  getIt.registerLazySingleton<IndividualChatMessageRepository>(
      () => IndividualChatMessageRepositoryImpl());
  getIt.registerLazySingleton<UsersRepository>(() => UsersRepositoryImpl());

  // usecases
  getIt.registerLazySingleton<GetAllChats>(
      () => GetAllChats(chatsRepository: getIt()));
  getIt.registerLazySingleton<GetAllNavigationItems>(
      () => GetAllNavigationItems(homeRepository: getIt()));
  getIt.registerLazySingleton<GetAllChatMessages>(
      () => GetAllChatMessages(individualChatMessageRepository: getIt()));
  getIt.registerLazySingleton<AddNewChatMessage>(
      () => AddNewChatMessage(individualChatMessageRepository: getIt()));
  getIt.registerLazySingleton<GetAllUsers>(
      () => GetAllUsers(usersRepository: getIt()));

  // bloc
  getIt.registerFactory<ChatsBloc>(() => ChatsBloc(getIt(), getIt()));
  getIt.registerFactory<HomeBloc>(() => HomeBloc(getIt(), getIt()));
  getIt.registerFactory<IndividualChatBloc>(
      () => IndividualChatBloc(getIt(), getIt(), getIt()));
  getIt.registerFactory<UsersBloc>(() => UsersBloc(getAllUsers: getIt()));
}
