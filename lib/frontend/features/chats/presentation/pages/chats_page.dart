import 'package:clean_arch_bloc_chat_app/frontend/features/chats/presentation/bloc/chats_bloc.dart';
import 'package:clean_arch_bloc_chat_app/frontend/features/individual_chat/presentation/bloc/individual_chat_bloc.dart';
import 'package:clean_arch_bloc_chat_app/frontend/features/individual_chat/presentation/pages/individual_chat_page.dart';
import 'package:clean_arch_bloc_chat_app/utils/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    print('inside chats page');
    final individualChatBloc = BlocProvider.of<IndividualChatBloc>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add_comment_rounded),
      ),
      body: Container(
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
                  return GestureDetector(
                    onTap: () {
                      individualChatBloc
                          .add(IndividualChatFetchDataEvent(currentChat: chat));
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => IndividualChatPage()));
                    },
                    child: ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.person_sharp),
                      ),
                      title: Text(chat.chatsTitle),
                      subtitle: Text(chat.chatsLastMessage),
                      trailing: Text(chat.chatsLastMessageTime.toString()),
                    ),
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
      ),
    );
  }
}
