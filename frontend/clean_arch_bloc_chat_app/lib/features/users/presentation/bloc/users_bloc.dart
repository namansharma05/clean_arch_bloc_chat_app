import 'dart:async';

import 'package:clean_arch_bloc_chat_app/features/users/domain/entities/users_entity.dart';
import 'package:clean_arch_bloc_chat_app/features/users/domain/usecases/get_all_users.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final GetAllUsers? getAllUsers;

  UsersBloc({this.getAllUsers}) : super(UsersInitial()) {
    on<UsersGetAllUsersEvent>(usersGetAllUsersEvent);
    on<UsersSelectionEvent>(usersSelectionEvent);
    on<UsersSocketEvent>(usersSocketEvent);
  }

  FutureOr<void> usersGetAllUsersEvent(
      UsersGetAllUsersEvent event, Emitter<UsersState> emit) async {
    emit(UsersLoadingState());
    final allUsers = await getAllUsers!.call();
    emit(UsersLoadedState(allUsers: allUsers));
  }

  FutureOr<void> usersSelectionEvent(
      UsersSelectionEvent event, Emitter<UsersState> emit) {
    emit(UsersSelectionState(selectedUser: event.selectedUser));
  }

  FutureOr<void> usersSocketEvent(
      UsersSocketEvent event, Emitter<UsersState> emit) {
    emit(UsersSocketState(socket: event.socket));
  }
}
