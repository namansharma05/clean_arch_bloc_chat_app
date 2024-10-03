import 'package:clean_arch_bloc_chat_app/features/chats/domain/entities/chats_entity.dart';
import 'package:clean_arch_bloc_chat_app/features/chats/presentation/bloc/chats_bloc.dart'; // Import ChatsBloc
import 'package:clean_arch_bloc_chat_app/features/chats/presentation/widgets/chats_list_tile_widget.dart';
import 'package:clean_arch_bloc_chat_app/features/users/domain/entities/users_entity.dart';
import 'package:clean_arch_bloc_chat_app/utils/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BodyWidget extends StatelessWidget {
  final UsersEntity? selectedUser;
  final int? currentIndex;
  const BodyWidget({super.key, this.selectedUser, this.currentIndex});

  @override
  Widget build(BuildContext context) {
    if (currentIndex == 0) {
      final chatsBloc = BlocProvider.of<ChatsBloc>(context);

      return Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            child: FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add_comment_rounded),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: theme().scaffoldBackgroundColor,
            ),
            child: BlocBuilder<ChatsBloc, ChatsState>(
              builder: (context, state) {
                print('inside chats page state is: $state');
                if (state is ChatsLoadingState) {
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                } else if (state is ChatsLoadedState) {
                  return ListView.builder(
                    itemCount: state.chats.length,
                    itemBuilder: (context, index) {
                      final chat = state.chats[index];
                      // final currentState = homeBloc.state as HomeLoadedState;
                      // // write selected user == chat code here
                      // if (currentState.user!.id == chat.id) {
                      //   return const SizedBox();
                      // }
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
        ],
      );
    } else if (currentIndex == 1) {
      return const Center(child: Text('Status Page'));
    } else {
      return const Center(child: Text('Calls Page'));
    }
  }

  // Chat list UI rendering
  Widget _buildChatList(List<ChatsEntity> chats) {
    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        final chat = chats[index];
        return ListTile(
          title: Text("${chat.firstName!} ${chat.lastName}"),
          subtitle: Text(chat.lastMessage!),
        );
      },
    );
  }
}
