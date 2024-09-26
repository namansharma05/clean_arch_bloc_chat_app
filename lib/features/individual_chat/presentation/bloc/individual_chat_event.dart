part of 'individual_chat_bloc.dart';

class IndividualChatEvent {}

class IndividualChatFetchDataEvent extends IndividualChatEvent {}

class IndividualChatConnectToSocketEvent extends IndividualChatEvent {
  final io.Socket socket;
  final ChatsEntity chat;

  IndividualChatConnectToSocketEvent(
      {required this.chat, required this.socket});
}

class IndividualChatDisconnectFromSocketEvent extends IndividualChatEvent {}

class IndividualChatAddNewMessageEvent extends IndividualChatEvent {
  final IndividualChatMessageEntity? newChatMessage;

  IndividualChatAddNewMessageEvent({this.newChatMessage});
}

class IndividualChatMessageChangedEvent extends IndividualChatEvent {}

class IndividualChatLoadedAppBarEvent extends IndividualChatEvent {
  final ChatsEntity? currentChat;

  IndividualChatLoadedAppBarEvent({this.currentChat});
}
