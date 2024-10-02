import 'dart:async';

import 'package:clean_arch_bloc_chat_app/features/chats/domain/entities/chats_entity.dart';
import 'package:clean_arch_bloc_chat_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/data/models/individual_chat_message_model.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/domain/entities/individual_chat_message_entity.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/domain/usecases/add_new_chat_message.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/domain/usecases/get_all_chat_messages.dart';
import 'package:clean_arch_bloc_chat_app/features/users/domain/entities/users_entity.dart';
import 'package:clean_arch_bloc_chat_app/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

part 'individual_chat_event.dart';
part 'individual_chat_state.dart';

class IndividualChatBloc
    extends Bloc<IndividualChatEvent, IndividualChatState> {
  io.Socket? _socket;

  final GetAllChatMessages? getAllChatMessages;
  final AddNewChatMessage? addNewChatMessage;
  final IndividualChatMessageModel? individualChatMessageModel;

  final homeBloc = HomeBloc(getIt());

  IndividualChatBloc(this.getAllChatMessages, this.addNewChatMessage,
      this.individualChatMessageModel)
      : super(IndividualChatInitial()) {
    on<IndividualChatFetchDataEvent>(individualChatFetchDataEvent);
    on<IndividualChatConnectToSocketEvent>(individualChatConnectToSocketEvent);
    on<IndividualChatDisconnectFromSocketEvent>(
        individualChatDisconnectFromSocketEvent);
    on<IndividualChatSendMessageEvent>(individualChatSendMessageEvent);

    on<IndividualChatMessageChangedEvent>(individualChatMessageChangedEvent);
    on<IndividualChatLoadedAppBarEvent>(individualChatLoadedAppBarEvent);
    on<IndividualChatAddNewMessageEvent>(individualChatAddNewMessageEvent);
  }

  Future<void> individualChatFetchDataEvent(IndividualChatFetchDataEvent event,
      Emitter<IndividualChatState> emit) async {
    try {
      print('inside individual chat fetch data event');
      final chatMessages = await getAllChatMessages!.call();
      print(
          'chatmessages length inside in individual chat fetch data event is: ${chatMessages.length}');
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
      _socket!.emit('signin', event.currentUser!.id);
      final chatMessages = await getAllChatMessages!.call();
      emit(IndividualChatLoadedState(
        chatMessages: chatMessages,
        currentChat: event.chat,
        socket: _socket!,
        currentUser: event.currentUser,
      ));
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

  Future<void> individualChatSendMessageEvent(
      IndividualChatSendMessageEvent event,
      Emitter<IndividualChatState> emit) async {
    final messageData = {
      'sourceId': event.sourceId,
      'targetId': event.targetid,
      'chatMessage': {
        'type': event.newChatMessage!.type,
        'message': event.newChatMessage!.message,
        'messageTime': event.newChatMessage!.messageTime!.toIso8601String(),
      }
    };
    _socket!.emit('message', messageData);
    await addNewChatMessage!.call(event.newChatMessage);
    final chatMessages = await getAllChatMessages!.call();
    emit(IndividualChatLoadedState(
      chatMessages: chatMessages,
      currentChat: event.currentChat,
      socket: _socket!,
      currentUser: event.currentUser,
    ));
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

  Future<void> individualChatAddNewMessageEvent(
      IndividualChatAddNewMessageEvent event,
      Emitter<IndividualChatState> emit) async {
    print(
        'event.jsonReceivedMessage.type is: ${event.jsonReceivedMessage!['type']}');
    print(
        'event.jsonReceivedMessage.message is: ${event.jsonReceivedMessage!['message']}');
    print(
        'event.jsonReceivedMessage.messageTime is: ${event.jsonReceivedMessage!['messageTime']}');
    final receivedMessage =
        individualChatMessageModel!.jsonToEntity(event.jsonReceivedMessage!);
    print('received message type is ${receivedMessage.type}');
    print('received message is ${receivedMessage.message}');
    print('received messagetime is ${receivedMessage.messageTime}');
    await addNewChatMessage!.call(receivedMessage);
    print('after adding new chat message');
    final chatMessages = await getAllChatMessages!.call();
    emit(IndividualChatLoadedState(
      chatMessages: chatMessages,
      currentChat: event.currentChat,
      socket: _socket!,
      currentUser: event.currentUser,
    ));
  }

  @override
  Future<void> close() {
    _socket?.disconnect();
    return super.close();
  }
}
