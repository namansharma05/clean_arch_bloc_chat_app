import 'dart:async';

import 'package:clean_arch_bloc_chat_app/features/chats/domain/entities/chats_entity.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/data/models/individual_chat_message_model.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/domain/entities/individual_chat_message_entity.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/domain/usecases/add_new_chat_message.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/domain/usecases/get_all_chat_messages.dart';
import 'package:clean_arch_bloc_chat_app/features/users/domain/entities/users_entity.dart';
import 'package:clean_arch_bloc_chat_app/features/users/presentation/bloc/users_bloc.dart';
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

  // final homeBloc = HomeBloc(getIt(), getIt());
  final usersBloc = UsersBloc(getAllUsers: getIt());

  IndividualChatBloc(this.getAllChatMessages, this.addNewChatMessage,
      this.individualChatMessageModel)
      : super(IndividualChatInitial()) {
    on<IndividualChatFetchDataEvent>(individualChatFetchDataEvent);

    on<IndividualChatSendMessageEvent>(individualChatSendMessageEvent);
  }

  Future<void> individualChatFetchDataEvent(IndividualChatFetchDataEvent event,
      Emitter<IndividualChatState> emit) async {
    try {
      print('inside individual chat fetch data event');
      _socket = event.socket;
      final chatMessages = await getAllChatMessages!
          .call(event.currentUser!.id, event.currentChat!.id);
      emit(IndividualChatLoadedState(
          chatMessages: chatMessages,
          currentChat: event.currentChat,
          currentUser: event.currentUser));
    } catch (e) {
      emit(IndividualChatErrorState());
    }
  }

  Future<void> individualChatSendMessageEvent(
      IndividualChatSendMessageEvent event,
      Emitter<IndividualChatState> emit) async {
    print('🔍 DEBUG: Starting message send process');

    try {
      // 2. Convert message
      print('🔄 Step 2: Converting message');
      final converted =
          IndividualChatMessageModel.fromEntity(event.newChatMessage!);
      final jsonData = converted.toJson();
      print('📋 Converted message data: $jsonData');

      // 3. Socket emit with error checking
      print('📡 Step 3: Checking socket status');
      if (_socket == null) {
        throw Exception('Socket is null');
      }
      if (!_socket!.connected) {
        print('⚠️ Socket not connected. Status: ${_socket!.connected}');
      }

      print('📤 Emitting socket message');
      _socket!.emit('message', jsonData);

      // 4. Local storage with try-catch
      print('💾 Step 4: Starting local storage');
      try {
        await addNewChatMessage!.call(event.newChatMessage);
        print('✅ Message added to local storage');
      } catch (e) {
        print('❌ Local storage error: $e');
        throw e;
      }

      // 5. Fetch messages with try-catch
      print('🔄 Step 5: Starting message fetch');
      late final List<IndividualChatMessageEntity> chatMessages;
      try {
        chatMessages = await getAllChatMessages!
            .call(event.currentUser!.id, event.currentChat!.id);
        print('✅ Fetched ${chatMessages.length} messages');
      } catch (e) {
        print('❌ Message fetch error: $e');
        throw e;
      }

      // 6. Emit new state
      print('⚡ Step 6: Creating new state');
      final currentState = state;
      if (currentState is IndividualChatLoadedState) {
        print('📊 Current messages: ${currentState.chatMessages?.length}');
        print('📊 New messages: ${chatMessages.length}');
      }

      final newState = IndividualChatLoadedState(
        chatMessages: chatMessages,
        currentChat: event.currentChat,
        socket: _socket!,
        currentUser: event.currentUser,
      );

      print('📤 Emitting new state');
      emit(newState);
      print('✅ New state emitted successfully');
    } catch (e, stackTrace) {
      print('❌ Error in message flow: $e');
      print('📋 Stack trace: $stackTrace');
      emit(IndividualChatErrorState());
    }
  }

  @override
  Future<void> close() {
    _socket?.disconnect();
    return super.close();
  }
}
