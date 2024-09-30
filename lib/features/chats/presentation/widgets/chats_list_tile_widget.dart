import 'package:clean_arch_bloc_chat_app/features/chats/data/models/chats_model.dart';
import 'package:clean_arch_bloc_chat_app/features/chats/data/repositories/chats_repository_impl.dart';
import 'package:clean_arch_bloc_chat_app/features/chats/domain/entities/chats_entity.dart';
import 'package:clean_arch_bloc_chat_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/data/models/individual_chat_message_model.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/data/repositories/individual_chat_message_repository_impl.dart';
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
        // print(msg['chatMessage']);
        // print('received msg type is: ${msg['type']}');
        // print('received msg is: ${msg['message']}');
        // print('received msg time is: ${msg['messageTime']}');
        individualChatBloc.add(IndividualChatAddNewMessageEvent(
            jsonReceivedMessage: msg['chatMessage'],
            currentUser: homeState.user,
            currentChat: chat));
      });
      individualChatBloc.add(IndividualChatConnectToSocketEvent(
          socket: socket, chat: chat, currentUser: homeState.user));
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        child: Icon(Icons.person_sharp),
      ),
      title: Text(chat.userEntity!.name!),
      subtitle: Text(chat.chatsLastMessage!),
      trailing: Text(chat.chatsLastMessageTime.toString()),
      onTap: () {
        connetToSocket(context);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const IndividualChatPage()));
      },
    );
  }
}
