import 'package:clean_arch_bloc_chat_app/features/chats/presentation/bloc/chats_bloc.dart';
import 'package:clean_arch_bloc_chat_app/features/chats/presentation/widgets/chats_list_tile_widget.dart';
import 'package:clean_arch_bloc_chat_app/utils/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    print('inside chats page');

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
                  return ChatsListTileWidget(chat: chat);
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
