import 'package:clean_arch_bloc_chat_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:clean_arch_bloc_chat_app/features/home/presentation/pages/home_page.dart';
import 'package:clean_arch_bloc_chat_app/features/users/presentation/bloc/users_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Users')),
      body: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          if (state is UsersLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UsersLoadedState) {
            return ListView.builder(
              itemCount: state.allUsers!.length,
              itemBuilder: (context, index) {
                final user = state.allUsers![index];
                return ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text(user.name!),
                  onTap: () {
                    homeBloc.add(HomeGetAllNavigationItemsEvent());
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage(
                                  selectedUser: user,
                                )));
                  },
                );
              },
            );
          } else if (state is UsersErrorState) {
            return Center(child: Text('Error'));
          } else {
            return Center(child: Text('No users found'));
          }
        },
      ),
    );
  }
}
