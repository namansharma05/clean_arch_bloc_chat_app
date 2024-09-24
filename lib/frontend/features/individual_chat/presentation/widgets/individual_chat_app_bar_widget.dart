import 'package:clean_arch_bloc_chat_app/frontend/features/individual_chat/presentation/bloc/individual_chat_bloc.dart';
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
          if (state is IndividualChatLoadingState) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          } else if (state is IndividualChatLoadedState) {
            return Padding(
              padding: const EdgeInsets.all(0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 30,
                      )),
                  CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(state.currentChatData.chatsTitle),
                ],
              ),
            );
          } else if (state is IndividualChatErrorState) {
            return const Center(
              child: Text('Some Error Occured'),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              CupertinoIcons.videocam,
              size: 30,
            )),
        IconButton(
            onPressed: () {},
            icon: Icon(
              CupertinoIcons.phone,
              size: 30,
            )),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              size: 30,
            )),
      ],
    );
  }
}
