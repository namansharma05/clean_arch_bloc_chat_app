import 'dart:async';

import 'package:clean_arch_bloc_chat_app/features/chats/domain/entities/chats_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'individual_chat_event.dart';
part 'individual_chat_state.dart';

class IndividualChatBloc
    extends Bloc<IndividualChatEvent, IndividualChatState> {
  IndividualChatBloc() : super(IndividualChatInitial()) {
    on<IndividualChatFetchDataEvent>(individualChatFetchDataEvent);
  }

  FutureOr<void> individualChatFetchDataEvent(
      IndividualChatFetchDataEvent event, Emitter<IndividualChatState> emit) {
    emit(IndividualChatLoadingState());
    emit(IndividualChatLoadedState(currentChatData: event.currentChat));
  }
}
