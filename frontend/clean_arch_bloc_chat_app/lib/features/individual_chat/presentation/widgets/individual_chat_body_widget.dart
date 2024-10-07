import 'package:clean_arch_bloc_chat_app/features/individual_chat/presentation/bloc/individual_chat_bloc.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/presentation/widgets/own_message_box.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/presentation/widgets/reply_message_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IndividualChatBodyWidget extends StatefulWidget {
  const IndividualChatBodyWidget({super.key});

  @override
  State<IndividualChatBodyWidget> createState() =>
      _IndividualChatBodyWidgetState();
}

class _IndividualChatBodyWidgetState extends State<IndividualChatBodyWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<IndividualChatBloc, IndividualChatState>(
      listenWhen: (previous, current) {
        print(
            '👂 ListenWhen - Previous: ${previous.runtimeType}, Current: ${current.runtimeType}');
        return true;
      },
      buildWhen: (previous, current) {
        print(
            '🏗️ BuildWhen - Previous: ${previous.runtimeType}, Current: ${current.runtimeType}');

        // Always rebuild for different state types
        if (previous.runtimeType != current.runtimeType) {
          print('📱 Rebuilding due to state type change');
          return true;
        }

        // For same state types, check message changes
        if (previous is IndividualChatLoadedState &&
            current is IndividualChatLoadedState) {
          final hasChanged =
              previous.chatMessages?.length != current.chatMessages?.length;
          print('📱 Messages changed: $hasChanged');
          return hasChanged;
        }

        return false;
      },
      listener: (context, state) {
        if (state is IndividualChatLoadedState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_scrollController.hasClients) {
              _scrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            }
          });
        }
      },
      builder: (context, state) {
        print('🎨 Building chat body with state: ${state.runtimeType}');

        if (state is IndividualChatLoadedState) {
          return ListView.builder(
            key: ValueKey('chat_list_${state.chatMessages?.length}'),
            controller: _scrollController,
            itemCount: state.chatMessages?.length ?? 0,
            itemBuilder: (context, index) {
              final message = state.chatMessages![index];
              return message.senderId == state.currentUser!.id
                  ? OwnMessageBox(
                      chatMessage: message,
                    )
                  : ReplyMessageBox(
                      chatMessage: message,
                    );
            },
          );
        } else if (state is IndividualChatLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(child: Text('No messages yet'));
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
