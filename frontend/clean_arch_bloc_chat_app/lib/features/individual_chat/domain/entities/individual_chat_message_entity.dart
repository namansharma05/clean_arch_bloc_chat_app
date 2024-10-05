class IndividualChatMessageEntity {
  int? senderId;
  int? receiverId;
  String? content;
  DateTime? timeStamp;

  IndividualChatMessageEntity({
    this.senderId,
    this.receiverId,
    this.content,
    this.timeStamp,
  });
}
