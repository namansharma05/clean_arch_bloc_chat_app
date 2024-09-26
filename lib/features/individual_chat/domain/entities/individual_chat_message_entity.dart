class IndividualChatMessageEntity {
  final String message;
  final DateTime messageTime;
  final bool fromMe;

  IndividualChatMessageEntity({
    required this.fromMe,
    required this.message,
    required this.messageTime,
  });
}
