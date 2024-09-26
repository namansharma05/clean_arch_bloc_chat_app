part of 'users_bloc.dart';

class UsersState {}

class UsersInitial extends UsersState {}

class UsersLoadingState extends UsersState {}

class UsersLoadedState extends UsersState {
  final List<UsersEntity>? allUsers;

  UsersLoadedState({this.allUsers});
}

class UsersErrorState extends UsersState {}
