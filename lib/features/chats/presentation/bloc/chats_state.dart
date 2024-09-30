part of 'chats_bloc.dart';

class ChatsState {}

class ChatsInitial extends ChatsState {}

class ChatsLoadingState extends ChatsState {}

class ChatsLoadedState extends ChatsState {
  final List<ChatsEntity> chats;

  ChatsLoadedState({required this.chats});
}

class ChatsErrorState extends ChatsState {}

class ChatsCurrentChatState extends ChatsState {
  final ChatsEntity? currentChat;

  ChatsCurrentChatState({this.currentChat});
}
