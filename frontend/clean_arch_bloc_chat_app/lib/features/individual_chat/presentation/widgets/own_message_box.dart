import 'package:clean_arch_bloc_chat_app/features/individual_chat/domain/entities/individual_chat_message_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OwnMessageBox extends StatelessWidget {
  final IndividualChatMessageEntity? chatMessage;
  const OwnMessageBox({super.key, this.chatMessage});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width / 4.5,
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: Colors.lightGreen.shade900,
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
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.done_all,
                        size: 20,
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
