part of 'individual_chat_bloc.dart';

class IndividualChatEvent {}

class IndividualChatFetchDataEvent extends IndividualChatEvent {
  final ChatsEntity? currentChat;
  final UsersEntity? currentUser;
  io.Socket? socket;

  IndividualChatFetchDataEvent(
      {this.socket, this.currentChat, this.currentUser});
}

class IndividualChatSendMessageEvent extends IndividualChatEvent {
  final IndividualChatMessageEntity? newChatMessage;
  final UsersEntity? currentUser;
  final ChatsEntity? currentChat;

  IndividualChatSendMessageEvent({
    this.currentUser,
    this.currentChat,
    this.newChatMessage,
  });
}
