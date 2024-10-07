import 'package:clean_arch_bloc_chat_app/features/chats/domain/entities/chats_entity.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/presentation/bloc/individual_chat_bloc.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/presentation/pages/individual_chat_page.dart';
import 'package:clean_arch_bloc_chat_app/features/users/domain/entities/users_entity.dart';
import 'package:clean_arch_bloc_chat_app/features/users/presentation/bloc/users_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsListTileWidget extends StatelessWidget {
  final ChatsEntity chat;
  final UsersEntity? user;
  const ChatsListTileWidget({
    super.key,
    required this.chat,
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    final individualChatBloc = BlocProvider.of<IndividualChatBloc>(context);
    final usersBloc = BlocProvider.of<UsersBloc>(context);
    return ListTile(
      leading: const CircleAvatar(
        child: Icon(Icons.person_sharp),
      ),
      title: Text("${chat.firstName!} ${chat.lastName!}"),
      subtitle: Text(chat.lastMessage!),
      trailing: Text(
          "${chat.lastMessageTime!.day}/${chat.lastMessageTime!.month}/${chat.lastMessageTime!.year}"),
      onTap: () {
        // connetToSocket(context);
        final usersState = usersBloc.state as UsersSocketState;
        individualChatBloc.add(IndividualChatFetchDataEvent(
            socket: usersState.socket, currentChat: chat, currentUser: user));
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const IndividualChatPage(),
          ),
        );
      },
    );
  }
}
