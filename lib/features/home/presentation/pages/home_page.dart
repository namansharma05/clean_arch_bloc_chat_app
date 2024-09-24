import 'package:clean_arch_bloc_chat_app/features/home/presentation/widgets/app_bar_widget.dart';
import 'package:clean_arch_bloc_chat_app/features/home/presentation/widgets/body_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(),
      body: BodyWidget(),
    );
  }
}
