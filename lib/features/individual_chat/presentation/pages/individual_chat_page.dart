import 'package:clean_arch_bloc_chat_app/features/individual_chat/presentation/widgets/individual_chat_app_bar_widget.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/presentation/widgets/individual_chat_bottom_bar_widget.dart';
import 'package:flutter/material.dart';

class IndividualChatPage extends StatelessWidget {
  const IndividualChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IndividualChatAppBarWidget(),
      bottomNavigationBar: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: IndividualChatBottomBarWidget(),
      ),
    );
  }
}
