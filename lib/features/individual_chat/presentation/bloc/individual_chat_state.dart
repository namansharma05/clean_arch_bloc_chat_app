part of 'individual_chat_bloc.dart';

class IndividualChatState {}

class IndividualChatInitial extends IndividualChatState {}

class IndividualChatLoadingState extends IndividualChatState {}

class IndividualChatLoadedState extends IndividualChatState {
  final ChatsEntity currentChatData;

  IndividualChatLoadedState({required this.currentChatData});
}

class IndividualChatErrorState extends IndividualChatState {}

class IndividualChatConnectToSocketState extends IndividualChatState {
  final io.Socket socket;

  IndividualChatConnectToSocketState({required this.socket});
}

class IndividualChatDisconnectFromSocketState extends IndividualChatState {}
