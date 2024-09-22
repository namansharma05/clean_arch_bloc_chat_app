class ChatsEntity {
  final int chatsId;
  final String chatsTitle;
  final String chatsLastMessage;
  final DateTime chatsLastMessageTime;

  ChatsEntity({
    required this.chatsId,
    required this.chatsTitle,
    required this.chatsLastMessage,
    required this.chatsLastMessageTime,
  });
}
