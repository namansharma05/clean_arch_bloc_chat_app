class IndividualChatMessageEntity {
  int? senderId;
  int? receiverId;
  String? content;
  String? timeStamp;

  IndividualChatMessageEntity({
    this.senderId,
    this.receiverId,
    this.content,
    this.timeStamp,
  });
}
