import 'package:clean_arch_bloc_chat_app/frontend/features/chats/domain/entities/chats_entity.dart';
import 'package:clean_arch_bloc_chat_app/frontend/features/chats/domain/usecases/get_all_chats.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chats_event.dart';
part 'chats_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  final GetAllChats getAllChats;
  ChatsBloc(this.getAllChats) : super(ChatsInitial()) {
    on<ChatsGetAllEvent>(chatsGetAllEvent);
  }

  Future<void> chatsGetAllEvent(
      ChatsGetAllEvent event, Emitter<ChatsState> emit) async {
    print('inside chats get all event');
    emit(ChatsLoadingState());
    final chats = await getAllChats.call();
    print(chats);

    emit(ChatsLoadedState(chats: chats));
  }
}
