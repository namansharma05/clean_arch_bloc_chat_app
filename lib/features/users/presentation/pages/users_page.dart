import 'package:clean_arch_bloc_chat_app/features/home/presentation/pages/home_page.dart';
import 'package:clean_arch_bloc_chat_app/features/users/domain/entities/users_entity.dart';
import 'package:clean_arch_bloc_chat_app/features/users/presentation/bloc/users_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final usersBloc = BlocProvider.of<UsersBloc>(context);
    return BlocConsumer<UsersBloc, UsersState>(
      bloc: usersBloc,
      listener: (context, state) {},
      builder: (context, state) {
        if (state is UsersLoadedState) {
          return Scaffold(
            body: ListView.builder(
              itemCount: state.allUsers!.length,
              itemBuilder: (context, index) {
                final currentUser = state.allUsers![index];
                return GestureDetector(
                  onTap: () {
                    usersBloc
                        .add(UsersSelectionEvent(selectedUser: currentUser));
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: Text(currentUser.name!),
                  ),
                );
              },
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
