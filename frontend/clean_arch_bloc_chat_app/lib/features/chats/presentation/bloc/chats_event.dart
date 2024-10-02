part of 'chats_bloc.dart';

class ChatsEvent {}

class ChatsGetAllEvent extends ChatsEvent {}

class ChatsCurrentChatEvent extends ChatsEvent {
  final ChatsEntity? currentChat;

  ChatsCurrentChatEvent({this.currentChat});
}
