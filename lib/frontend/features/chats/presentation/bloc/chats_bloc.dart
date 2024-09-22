import 'package:clean_arch_bloc_chat_app/frontend/features/chats/domain/entities/chats_entity.dart';
import 'package:clean_arch_bloc_chat_app/frontend/features/chats/domain/repositories/chats_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chats_event.dart';
part 'chats_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  final ChatsRepository chatsRepository;
  ChatsBloc(this.chatsRepository) : super(ChatsInitial()) {
    on<ChatsGetAllEvent>(chatsGetAllEvent);
  }

  Future<void> chatsGetAllEvent(
      ChatsGetAllEvent event, Emitter<ChatsState> emit) async {
    emit(ChatsLoadingState());
    final chats = await chatsRepository.getAllChats();

    emit(ChatsLoadedState(chats: chats));
  }
}
