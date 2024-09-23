part of 'home_bloc.dart';

class HomeEvent {}

class HomeGetAllNavigationItemsEvent extends HomeEvent {}

class HomeSwitchTabEvent extends HomeEvent {
  final int index;

  HomeSwitchTabEvent({required this.index});
}
