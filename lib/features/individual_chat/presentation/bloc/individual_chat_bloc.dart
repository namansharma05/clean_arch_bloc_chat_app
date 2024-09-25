import 'dart:async';

import 'package:clean_arch_bloc_chat_app/features/chats/domain/entities/chats_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

part 'individual_chat_event.dart';
part 'individual_chat_state.dart';

class IndividualChatBloc
    extends Bloc<IndividualChatEvent, IndividualChatState> {
  io.Socket? _socket;
  IndividualChatBloc() : super(IndividualChatInitial()) {
    on<IndividualChatFetchDataEvent>(individualChatFetchDataEvent);
    on<IndividualChatConnectToSocketEvent>(individualChatConnectToSocketEvent);
    on<IndividualChatDisconnectFromSocketEvent>(
        individualChatDisconnectFromSocketEvent);
  }

  FutureOr<void> individualChatFetchDataEvent(
      IndividualChatFetchDataEvent event, Emitter<IndividualChatState> emit) {
    emit(IndividualChatLoadingState());
    emit(IndividualChatLoadedState(currentChatData: event.currentChat));
  }

  FutureOr<void> individualChatConnectToSocketEvent(
      IndividualChatConnectToSocketEvent event,
      Emitter<IndividualChatState> emit) {
    _socket = event.socket;
    print('inside individual chat connect to socket event');
    add(IndividualChatFetchDataEvent(currentChat: event.chat));
    emit(IndividualChatConnectToSocketState(socket: _socket!));
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
}
