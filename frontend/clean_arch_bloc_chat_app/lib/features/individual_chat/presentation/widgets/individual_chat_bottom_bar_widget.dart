import 'package:clean_arch_bloc_chat_app/features/chats/presentation/bloc/chats_bloc.dart';
import 'package:clean_arch_bloc_chat_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/domain/entities/individual_chat_message_entity.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/presentation/bloc/individual_chat_bloc.dart';
import 'package:clean_arch_bloc_chat_app/utils/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IndividualChatBottomBarWidget extends StatelessWidget {
  IndividualChatBottomBarWidget({super.key});
  final TextEditingController chatMessageBoxController =
      TextEditingController();
  sendMessage(chatsBloc, homeBloc, individualChatBloc) {
    final state1 = homeBloc.state as HomeLoadedState;
    final state2 = individualChatBloc.state as IndividualChatLoadedState;
    individualChatBloc.add(
      IndividualChatSendMessageEvent(
        currentChat: state2.currentChat,
        currentUser: state1.user,
        newChatMessage: IndividualChatMessageEntity(
          type: 'Source',
          message: chatMessageBoxController.text,
          messageTime: DateTime.now(),
        ),
        sourceId: state1.user!.id,
        targetid: state2.currentChat!.userEntity!.id,
      ),
    );
    chatMessageBoxController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    final individualChatBloc = BlocProvider.of<IndividualChatBloc>(context);
    final chatsBloc = BlocProvider.of<ChatsBloc>(context);
    return Container(
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          // chatting area
          Expanded(
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: theme().secondaryHeaderColor,
                borderRadius: BorderRadius.circular(27),
              ),
              child: Row(
                children: [
                  // icon pallet
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.emoji_emotions_outlined,
                        size: 30,
                      )),
                  // textfield
                  Expanded(
                    child: TextField(
                      // autofocus: true,
                      controller: chatMessageBoxController,

                      decoration: const InputDecoration(
                        hintText: 'Message',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  // attachment, money transfer, camera
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.attach_file,
                            size: 30,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            CupertinoIcons.money_dollar_circle_fill,
                            size: 30,
                          )),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.camera_alt_outlined,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(
            width: 5,
          ),
          // record audio
          ValueListenableBuilder(
            valueListenable: chatMessageBoxController,
            builder: (context, value, child) {
              final bool isEmpty = value.text.isEmpty;
              return GestureDetector(
                onTap: isEmpty
                    ? () {}
                    : () {
                        sendMessage(chatsBloc, homeBloc, individualChatBloc);
                      },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: theme().primaryColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Icon(
                    isEmpty ? Icons.mic : Icons.send,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
