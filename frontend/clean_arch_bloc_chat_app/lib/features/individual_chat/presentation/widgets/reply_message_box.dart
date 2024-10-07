import 'package:clean_arch_bloc_chat_app/features/individual_chat/domain/entities/individual_chat_message_entity.dart';
import 'package:clean_arch_bloc_chat_app/utils/theme/theme.dart';
import 'package:flutter/material.dart';

class ReplyMessageBox extends StatelessWidget {
  final IndividualChatMessageEntity? chatMessage;
  const ReplyMessageBox({super.key, this.chatMessage});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: theme().secondaryHeaderColor,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 30,
                  top: 5,
                  bottom: 20,
                ),
                child: Text(
                  '${chatMessage!.content}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              Positioned(
                  bottom: 4,
                  right: 10,
                  child: Row(
                    children: [
                      Text(
                        "${chatMessage!.timeStamp!.hour}:${chatMessage!.timeStamp!.minute}",
                        style: TextStyle(
                            fontSize: 13, color: Colors.grey.shade600),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
