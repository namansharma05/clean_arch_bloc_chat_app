import 'package:clean_arch_bloc_chat_app/features/chats/presentation/bloc/chats_bloc.dart';
import 'package:clean_arch_bloc_chat_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:clean_arch_bloc_chat_app/features/home/presentation/pages/home_page.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/presentation/bloc/individual_chat_bloc.dart';
import 'package:clean_arch_bloc_chat_app/features/users/presentation/bloc/users_bloc.dart';
import 'package:clean_arch_bloc_chat_app/features/users/presentation/pages/users_page.dart';
import 'package:clean_arch_bloc_chat_app/injection_container.dart';
import 'package:clean_arch_bloc_chat_app/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ChatsBloc(
            getIt(),
          )..add(ChatsGetAllEvent()),
        ),
        BlocProvider(
          create: (_) => HomeBloc(getIt())
            ..add(
              HomeGetAllNavigationItemsEvent(),
            ),
        ),
        BlocProvider(
          create: (_) => IndividualChatBloc(
            getIt(),
            getIt(),
          ),
        ),
        BlocProvider(
          create: (_) => UsersBloc(
            getAllUsers: getIt(),
          )..add(
              UsersGetAllUsersEvent(),
            ),
        ),
      ],
      child: MaterialApp(
        title: 'Chat App',
        debugShowCheckedModeBanner: false,
        theme: theme(),
        home: const UsersPage(),
      ),
    );
  }
}
