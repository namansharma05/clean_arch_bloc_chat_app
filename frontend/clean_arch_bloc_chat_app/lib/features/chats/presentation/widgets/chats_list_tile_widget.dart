import 'package:clean_arch_bloc_chat_app/features/chats/domain/entities/chats_entity.dart';
import 'package:clean_arch_bloc_chat_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/presentation/bloc/individual_chat_bloc.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/presentation/pages/individual_chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class ChatsListTileWidget extends StatelessWidget {
  final ChatsEntity chat;

  const ChatsListTileWidget({
    super.key,
    required this.chat,
  });
  connetToSocket(BuildContext context) {
    final individualChatBloc = BlocProvider.of<IndividualChatBloc>(context);
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    final homeState = homeBloc.state as HomeLoadedState;
    final socket = io.io('http://192.168.1.8:3000/', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    socket.onConnect((_) {
      print('Connected to the socket server');
      socket.on("message", (msg) {
        individualChatBloc.add(IndividualChatAddNewMessageEvent(
            jsonReceivedMessage: msg['chatMessage'],
            currentUser: homeState.user,
            currentChat: chat));
      });
    });
    individualChatBloc.add(IndividualChatConnectToSocketEvent(
        socket: socket, chat: chat, currentUser: homeState.user));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        child: Icon(Icons.person_sharp),
      ),
      // title:
      //     Text("${chat.userEntity!.firstName!} ${chat.userEntity!.lastName!}"),
      // subtitle: Text(chat.chatsLastMessage!),
      // trailing: Text(chat.chatsLastMessageTime.toString()),
      title: Text("random"),
      subtitle: Text("subtitle"),
      trailing: Text("last Message"),
      onTap: () {
        connetToSocket(context);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const IndividualChatPage(),
          ),
        );
      },
    );
  }
}
