import 'package:clean_arch_bloc_chat_app/features/chats/presentation/bloc/chats_bloc.dart';
import 'package:clean_arch_bloc_chat_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:clean_arch_bloc_chat_app/features/home/presentation/widgets/app_bar_widget.dart';
import 'package:clean_arch_bloc_chat_app/features/home/presentation/widgets/body_widget.dart';
import 'package:clean_arch_bloc_chat_app/features/users/domain/entities/users_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  final UsersEntity? selectedUser;
  const HomePage({super.key, this.selectedUser});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final chatsBloc = BlocProvider.of<ChatsBloc>(context);
    if (widget.selectedUser != null) {
      chatsBloc.add(ChatsGetAllEvent(user: widget.selectedUser));
    }
  }

  @override
  Widget build(BuildContext context) {
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    // Access ChatsBloc

    // Fetch chats when HomePage is loaded with selectedUser
    return Scaffold(
      appBar: const AppBarWidget(),
      body: BodyWidget(
          selectedUser: widget.selectedUser, currentIndex: _currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          // Trigger event in HomeBloc to handle tab switching
          homeBloc
              .add(HomeSwitchTabEvent(user: widget.selectedUser, index: index));
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chats"),
          BottomNavigationBarItem(icon: Icon(Icons.circle), label: "Status"),
          BottomNavigationBarItem(icon: Icon(Icons.call), label: "Calls"),
        ],
      ),
    );
  }
}
