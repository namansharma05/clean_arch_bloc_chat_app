import 'dart:async';

import 'package:clean_arch_bloc_chat_app/features/chats/domain/entities/chats_entity.dart';
import 'package:clean_arch_bloc_chat_app/features/chats/domain/usecases/get_all_chats.dart';
import 'package:clean_arch_bloc_chat_app/features/users/domain/entities/users_entity.dart';
import 'package:clean_arch_bloc_chat_app/features/users/presentation/bloc/users_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chats_event.dart';
part 'chats_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  final GetAllChats? getAllChats;
  final UsersBloc? usersBloc;
  ChatsBloc(this.getAllChats, this.usersBloc) : super(ChatsInitial()) {
    on<ChatsGetAllEvent>(chatsGetAllEvent);

    on<ChatsCurrentChatEvent>(chatsCurrentChatEvent);
  }

  Future<void> chatsGetAllEvent(
      ChatsGetAllEvent event, Emitter<ChatsState> emit) async {
    print('inside chats get all event');
    emit(ChatsLoadingState());
    print("user id: ${event.user!.id}");
    final chats = await getAllChats!.call(event.user!.id);
    // print(chats);
    emit(ChatsLoadedState(chats: chats));
  }

  FutureOr<void> chatsCurrentChatEvent(
      ChatsCurrentChatEvent event, Emitter<ChatsState> emit) {
    emit(ChatsCurrentChatState(currentChat: event.currentChat));
  }
}
