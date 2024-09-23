part of 'home_bloc.dart';

class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<HomeEntity> homeNavigationitems;

  HomeLoadedState({required this.homeNavigationitems});
}

class HomeErrorState extends HomeState {}

class HomeSwitchToChatsState extends HomeState {
  final int index;

  HomeSwitchToChatsState({required this.index});
}

class HomeSwitchToStatusState extends HomeState {
  final int index;

  HomeSwitchToStatusState({required this.index});
}
