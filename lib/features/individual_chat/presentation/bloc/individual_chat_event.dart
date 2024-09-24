part of 'individual_chat_bloc.dart';

class IndividualChatEvent {}

class IndividualChatFetchDataEvent extends IndividualChatEvent {
  final ChatsEntity currentChat;

  IndividualChatFetchDataEvent({required this.currentChat});
}
