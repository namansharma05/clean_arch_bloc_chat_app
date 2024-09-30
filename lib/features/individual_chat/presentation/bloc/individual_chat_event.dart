part of 'individual_chat_bloc.dart';

class IndividualChatEvent {}

class IndividualChatFetchDataEvent extends IndividualChatEvent {}

class IndividualChatConnectToSocketEvent extends IndividualChatEvent {
  final io.Socket socket;
  final ChatsEntity chat;
  final UsersEntity? currentUser;

  IndividualChatConnectToSocketEvent(
      {this.currentUser, required this.chat, required this.socket});
}

class IndividualChatDisconnectFromSocketEvent extends IndividualChatEvent {}

class IndividualChatSendMessageEvent extends IndividualChatEvent {
  final IndividualChatMessageEntity? newChatMessage;
  final int? sourceId;
  final int? targetid;
  final UsersEntity? currentUser;
  final ChatsEntity? currentChat;

  IndividualChatSendMessageEvent({
    this.currentUser,
    this.currentChat,
    this.sourceId,
    this.targetid,
    this.newChatMessage,
  });
}

class IndividualChatMessageChangedEvent extends IndividualChatEvent {}

class IndividualChatLoadedAppBarEvent extends IndividualChatEvent {
  final ChatsEntity? currentChat;

  IndividualChatLoadedAppBarEvent({this.currentChat});
}

class IndividualChatAddNewMessageEvent extends IndividualChatEvent {
  final Map<String, dynamic>? jsonReceivedMessage;
  final ChatsEntity? currentChat;
  final UsersEntity? currentUser;

  IndividualChatAddNewMessageEvent(
      {this.currentChat, this.currentUser, this.jsonReceivedMessage});
}
