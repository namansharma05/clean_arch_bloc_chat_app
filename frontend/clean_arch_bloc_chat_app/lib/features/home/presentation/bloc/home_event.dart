part of 'home_bloc.dart';

class HomeEvent {}

class HomeGetAllNavigationItemsEvent extends HomeEvent {
  final UsersEntity? user;

  HomeGetAllNavigationItemsEvent({this.user});
}

class HomeSwitchTabEvent extends HomeEvent {
  final int index;
  final UsersEntity? user;

  HomeSwitchTabEvent({this.user, required this.index});
}
