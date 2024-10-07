import 'package:clean_arch_bloc_chat_app/features/home/presentation/pages/home_page.dart';
import 'package:clean_arch_bloc_chat_app/features/users/domain/entities/users_entity.dart';
import 'package:clean_arch_bloc_chat_app/features/users/presentation/bloc/users_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  connectToSocket(BuildContext context, UsersEntity? user) {
    final usersBloc = BlocProvider.of<UsersBloc>(context);
    final socket = io.io('http://192.168.1.9:3000/', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();
    socket.onConnect((_) {
      socket.emit("signin", user!.id);
    });

    usersBloc.add(UsersSocketEvent(socket: socket));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          if (state is UsersLoadingState) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (state is UsersLoadedState) {
            return ListView.builder(
              itemCount: state.allUsers!.length,
              itemBuilder: (context, index) {
                final user = state.allUsers![index];
                return ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text("${user.firstName!} ${user.lastName}"),
                  onTap: () {
                    // print(user);
                    connectToSocket(context, user);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(
                          selectedUser: user,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is UsersErrorState) {
            return const Center(child: Text('Error'));
          } else {
            return const Center(child: Text('No users found'));
          }
        },
      ),
    );
  }
}
