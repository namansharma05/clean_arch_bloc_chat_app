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
        print('inside individual chat body widget');
        if (state is IndividualChatLoadedState) {
          print('inside state is individual chat loaded state');
          print(
              'chat messages length: ${state.chatMessages!.length.toString()}');
          return ListView.builder(
            itemCount: state.chatMessages!.length,
            itemBuilder: (context, index) {
              final chatMessage = state.chatMessages![index];
              if (chatMessage.senderId == state.currentUser!.id) {
                return OwnMessageBox(
                  chatMessage: chatMessage,
                );
              } else {
                return ReplyMessageBox(
                  chatMessage: chatMessage,
                );
              }
            },
          );
        } else if (state is IndividualChatLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(child: Text('No messages yet'));
        }
      },
    );
  }
}
