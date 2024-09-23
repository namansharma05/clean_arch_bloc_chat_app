import 'package:clean_arch_bloc_chat_app/frontend/features/chats/presentation/bloc/chats_bloc.dart';
import 'package:clean_arch_bloc_chat_app/utils/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: theme().scaffoldBackgroundColor,
      ),
      child: BlocBuilder<ChatsBloc, ChatsState>(
        builder: (context, state) {
          if (state is ChatsLoadingState) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          } else if (state is ChatsLoadedState) {
            return ListView.builder(
              itemCount: state.chats.length,
              itemBuilder: (context, index) {
                final chat = state.chats[index];
                return ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.person_sharp),
                  ),
                  title: Text(chat.chatsTitle),
                  subtitle: Text(chat.chatsLastMessage),
                  trailing: Text(chat.chatsLastMessageTime.toString()),
                );
              },
            );
          } else if (state is ChatsErrorState) {
            return const SizedBox();
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
