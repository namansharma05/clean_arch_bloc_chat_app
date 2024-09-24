import 'package:clean_arch_bloc_chat_app/features/chats/domain/entities/chats_entity.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/presentation/bloc/individual_chat_bloc.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/presentation/pages/individual_chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class ChatsListTileWidget extends StatelessWidget {
  final ChatsEntity chat;
  const ChatsListTileWidget({super.key, required this.chat});

  connetToSocket() {
    final socket = io.io('http://192.168.1.8:3000/', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    socket.onConnect((_) {
      print('Connected to the socket server');
    });

    socket.onDisconnect((_) {
      print('Disconnected from the socket server');
    });

    socket.on('message', (data) {
      print('Received message: $data');
    });
  }

  @override
  Widget build(BuildContext context) {
    final individualChatBloc = BlocProvider.of<IndividualChatBloc>(context);
    return GestureDetector(
      onTap: () {
        connetToSocket();
        individualChatBloc.add(IndividualChatFetchDataEvent(currentChat: chat));
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => IndividualChatPage()));
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
  }
}
