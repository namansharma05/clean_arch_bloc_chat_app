import 'package:clean_arch_bloc_chat_app/features/individual_chat/presentation/bloc/individual_chat_bloc.dart';
import 'package:clean_arch_bloc_chat_app/utils/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IndividualChatAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(70);
  const IndividualChatAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: theme().scaffoldBackgroundColor,
      automaticallyImplyLeading: false,
      title: BlocBuilder<IndividualChatBloc, IndividualChatState>(
        builder: (context, state) {
          if (state is IndividualChatLoadedAppBarState) {
            return _buildAppBarContent(context, state);
          } else if (state is IndividualChatLoadedState &&
              state.currentChat != null) {
            return _buildAppBarContent(context, state);
          } else {
            return const SizedBox(); // or some loading indicator
          }
        },
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(CupertinoIcons.videocam, size: 30),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(CupertinoIcons.phone, size: 30),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.more_vert, size: 30),
        ),
      ],
    );
  }

  Widget _buildAppBarContent(BuildContext context, dynamic state) {
    final chatData = state is IndividualChatLoadedAppBarState
        ? state.currentChatData
        : (state as IndividualChatLoadedState).currentChat;

    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).maybePop();
            },
            icon: const Icon(Icons.arrow_back, size: 30),
          ),
          const CircleAvatar(
            child: Icon(Icons.person),
          ),
          const SizedBox(width: 10),
          Text(chatData?.chatsTitle ?? 'Chat'),
        ],
      ),
    );
  }
}
