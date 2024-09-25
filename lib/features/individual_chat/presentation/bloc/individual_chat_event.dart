part of 'individual_chat_bloc.dart';

class IndividualChatEvent {}

class IndividualChatFetchDataEvent extends IndividualChatEvent {
  final ChatsEntity currentChat;

  IndividualChatFetchDataEvent({required this.currentChat});
}

class IndividualChatConnectToSocketEvent extends IndividualChatEvent {
  final io.Socket socket;
  final ChatsEntity chat;

  IndividualChatConnectToSocketEvent(
      {required this.chat, required this.socket});
}

class IndividualChatDisconnectFromSocketEvent extends IndividualChatEvent {}
