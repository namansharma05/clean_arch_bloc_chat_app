import 'package:clean_arch_bloc_chat_app/features/individual_chat/presentation/bloc/individual_chat_bloc.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/presentation/widgets/individual_chat_app_bar_widget.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/presentation/widgets/individual_chat_bottom_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IndividualChatPage extends StatelessWidget {
  const IndividualChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final individualChatBloc = BlocProvider.of<IndividualChatBloc>(context);
        return PopScope(
          onPopInvokedWithResult: (didPop, result) async {
            individualChatBloc.add(IndividualChatDisconnectFromSocketEvent());
          },
          child: Scaffold(
            appBar: IndividualChatAppBarWidget(),
            bottomNavigationBar: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: IndividualChatBottomBarWidget(),
            ),
          ),
        );
      },
    );
  }
}
