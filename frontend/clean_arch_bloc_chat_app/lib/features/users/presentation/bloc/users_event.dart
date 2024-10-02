part of 'users_bloc.dart';

class UsersEvent {}

class UsersGetAllUsersEvent extends UsersEvent {}

class UsersSelectionEvent extends UsersEvent {
  final UsersEntity? selectedUser;

  UsersSelectionEvent({this.selectedUser});
}
