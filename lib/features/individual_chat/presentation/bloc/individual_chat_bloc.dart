import 'dart:async';

import 'package:clean_arch_bloc_chat_app/features/chats/domain/entities/chats_entity.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/domain/entities/individual_chat_message_entity.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/domain/usecases/add_new_chat_message.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/domain/usecases/get_all_chat_messages.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

part 'individual_chat_event.dart';
part 'individual_chat_state.dart';

class IndividualChatBloc
    extends Bloc<IndividualChatEvent, IndividualChatState> {
  io.Socket? _socket;

  final GetAllChatMessages? getAllChatMessages;
  final AddNewChatMessage? addNewChatMessage;

  IndividualChatBloc(this.getAllChatMessages, this.addNewChatMessage)
      : super(IndividualChatInitial()) {
    on<IndividualChatFetchDataEvent>(individualChatFetchDataEvent);
    on<IndividualChatConnectToSocketEvent>(individualChatConnectToSocketEvent);
    on<IndividualChatDisconnectFromSocketEvent>(
        individualChatDisconnectFromSocketEvent);
    on<IndividualChatAddNewMessageEvent>(individualChatAddNewMessageEvent);

    on<IndividualChatMessageChangedEvent>(individualChatMessageChangedEvent);
    on<IndividualChatLoadedAppBarEvent>(individualChatLoadedAppBarEvent);
  }

  Future<void> individualChatFetchDataEvent(IndividualChatFetchDataEvent event,
      Emitter<IndividualChatState> emit) async {
    try {
      final chatMessages = await getAllChatMessages!.call();
      emit(IndividualChatLoadedState(chatMessages: chatMessages));
    } catch (e) {
      emit(IndividualChatErrorState());
    }
  }

  FutureOr<void> individualChatConnectToSocketEvent(
      IndividualChatConnectToSocketEvent event,
      Emitter<IndividualChatState> emit) async {
    _socket = event.socket;
    print('inside individual chat connect to socket event');
    emit(IndividualChatLoadingState());

    try {
      final chatMessages = await getAllChatMessages!.call();
      emit(IndividualChatLoadedState(
          chatMessages: chatMessages,
          currentChat: event.chat,
          socket: _socket!));
    } catch (e) {
      emit(IndividualChatErrorState());
    }
  }

  FutureOr<void> individualChatDisconnectFromSocketEvent(
      IndividualChatDisconnectFromSocketEvent event,
      Emitter<IndividualChatState> emit) {
    if (_socket != null) {
      _socket!.disconnect();
      _socket = null;
      print('Socket disconnected');
      emit(IndividualChatDisconnectFromSocketState());
    }
  }

  @override
  Future<void> close() {
    _socket?.disconnect();
    return super.close();
  }

  Future<void> individualChatAddNewMessageEvent(
      IndividualChatAddNewMessageEvent event,
      Emitter<IndividualChatState> emit) async {
    await addNewChatMessage!.call(event.newChatMessage);

    add(IndividualChatFetchDataEvent());
  }

  FutureOr<void> individualChatMessageChangedEvent(
      IndividualChatMessageChangedEvent event,
      Emitter<IndividualChatState> emit) {
    emit(IndividualChatMessageChangedState());
  }

  FutureOr<void> individualChatLoadedAppBarEvent(
      IndividualChatLoadedAppBarEvent event,
      Emitter<IndividualChatState> emit) {
    emit(IndividualChatLoadedAppBarState(currentChatData: event.currentChat));
  }
}
