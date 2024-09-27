import 'package:clean_arch_bloc_chat_app/features/users/presentation/bloc/users_bloc.dart';
import 'package:clean_arch_bloc_chat_app/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    final usersBloc = BlocProvider.of<UsersBloc>(context);
    return SafeArea(
      child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: theme().scaffoldBackgroundColor,
          ),
          child: Row(
            children: [
              // back button
              IconButton(
                onPressed: () {
                  usersBloc.add(UsersGetAllUsersEvent());
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back),
              ),
              // title
              Text(
                'ChatsApp',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          )),
    );
  }
}
