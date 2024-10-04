import 'package:clean_arch_bloc_chat_app/features/chats/presentation/pages/chats_page.dart';
import 'package:clean_arch_bloc_chat_app/features/users/domain/entities/users_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BodyWidget extends StatelessWidget {
  final UsersEntity? selectedUser;
  final int? currentIndex;
  const BodyWidget({super.key, this.selectedUser, this.currentIndex});

  @override
  Widget build(BuildContext context) {
    if (currentIndex == 0) {
      return ChatsPage(
        user: selectedUser,
      );
    } else if (currentIndex == 1) {
      return const Center(child: Text('Status Page'));
    } else {
      return const Center(child: Text('Calls Page'));
    }
  }
}
