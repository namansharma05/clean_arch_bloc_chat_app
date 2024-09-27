import 'package:clean_arch_bloc_chat_app/features/home/presentation/widgets/app_bar_widget.dart';
import 'package:clean_arch_bloc_chat_app/features/home/presentation/widgets/body_widget.dart';
import 'package:clean_arch_bloc_chat_app/features/users/domain/entities/users_entity.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final UsersEntity selectedUser;
  const HomePage({super.key, required this.selectedUser});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(),
      body: BodyWidget(),
    );
  }
}
