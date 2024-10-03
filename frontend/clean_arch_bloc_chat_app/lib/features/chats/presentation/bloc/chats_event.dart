part of 'chats_bloc.dart';

class ChatsEvent {}

class ChatsGetAllEvent extends ChatsEvent {
  final UsersEntity? user;

  ChatsGetAllEvent({this.user});
}

class ChatsCurrentChatEvent extends ChatsEvent {
  final ChatsEntity? currentChat;

  ChatsCurrentChatEvent({this.currentChat});
}
