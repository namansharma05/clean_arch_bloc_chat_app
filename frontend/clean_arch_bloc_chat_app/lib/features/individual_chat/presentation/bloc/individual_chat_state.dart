part of 'individual_chat_bloc.dart';

class IndividualChatState {}

class IndividualChatInitial extends IndividualChatState {}

class IndividualChatLoadingState extends IndividualChatState {}

class IndividualChatLoadedState extends IndividualChatState {
  final List<IndividualChatMessageEntity>? chatMessages;
  final ChatsEntity? currentChat;
  final io.Socket? socket;
  final UsersEntity? currentUser;

  IndividualChatLoadedState(
      {this.currentUser, this.chatMessages, this.currentChat, this.socket});
}

class IndividualChatErrorState extends IndividualChatState {}

class IndividualChatConnectToSocketState extends IndividualChatState {
  final io.Socket socket;

  IndividualChatConnectToSocketState({required this.socket});
}
