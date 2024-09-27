import 'package:clean_arch_bloc_chat_app/features/home/presentation/pages/home_page.dart';
import 'package:clean_arch_bloc_chat_app/features/users/presentation/bloc/users_bloc.dart';
import 'package:clean_arch_bloc_chat_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UsersBloc(getAllUsers: getIt())..add(UsersGetAllUsersEvent()),
      child: Scaffold(
        appBar: AppBar(title: Text('Users')),
        body: BlocConsumer<UsersBloc, UsersState>(
          listener: (context, state) {
            if (state is UsersSelectionState) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: BlocProvider.of<UsersBloc>(context),
                    child: HomePage(selectedUser: state.selectedUser!),
                  ),
                ),
              );
            }
          },
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
                      context
                          .read<UsersBloc>()
                          .add(UsersSelectionEvent(selectedUser: user));
                    },
                  );
                },
              );
            } else if (state is UsersErrorState) {
              return Center(child: Text('Error'));
            }
            return Center(child: Text('No users found'));
          },
        ),
      ),
    );
  }
}
