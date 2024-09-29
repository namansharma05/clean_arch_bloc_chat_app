import 'package:clean_arch_bloc_chat_app/features/individual_chat/presentation/bloc/individual_chat_bloc.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/presentation/widgets/own_message_box.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/presentation/widgets/reply_message_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IndividualChatBodyWidget extends StatelessWidget {
  const IndividualChatBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IndividualChatBloc, IndividualChatState>(
      builder: (context, state) {
        if (state is IndividualChatLoadedState) {
          return ListView.builder(
            itemCount: state.chatMessages?.length ?? 0,
            itemBuilder: (context, index) {
              final chatMessage = state.chatMessages![index];
              if (chatMessage.type == "Source") {
                return OwnMessageBox();
              } else {
                return ReplyMessageBox();
              }
              // return Container(
              //   decoration: BoxDecoration(
              //     color: chatMessage.fromMe
              //         ? Colors.lightGreen.shade900
              //         : theme().secondaryHeaderColor,
              //   ),
              //   child: Column(
              //     children: [
              //       Text(chatMessage.message),
              //       Text(
              //           '${chatMessage.messageTime.hour}:${chatMessage.messageTime.minute}'),
              //     ],
              //   ),
              // );
            },
          );
        } else if (state is IndividualChatLoadingState) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Center(child: Text('No messages yet'));
        }
      },
    );
  }
}
