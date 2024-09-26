import 'dart:async';

import 'package:clean_arch_bloc_chat_app/features/users/domain/entities/users_entity.dart';
import 'package:clean_arch_bloc_chat_app/features/users/domain/usecases/get_all_users.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final GetAllUsers? getAllUsers;
  UsersBloc({this.getAllUsers}) : super(UsersInitial()) {
    on<UsersGetAllUsersEvent>(usersGetAllUsersEvent);
  }

  FutureOr<void> usersGetAllUsersEvent(
      UsersGetAllUsersEvent event, Emitter<UsersState> emit) async {
    emit(UsersLoadingState());
    final allUsers = await getAllUsers!.call();
    emit(UsersLoadedState(allUsers: allUsers));
  }
}
