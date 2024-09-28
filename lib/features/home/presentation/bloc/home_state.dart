part of 'home_bloc.dart';

class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final Widget? initialContent;
  final List<HomeEntity>? homeNavigationItems;
  final UsersEntity? user;

  HomeLoadedState({this.initialContent, this.homeNavigationItems, this.user});
}

class HomeErrorState extends HomeState {
  final Object error;

  HomeErrorState({required this.error});
}

class HomeSwitchTabState extends HomeState {
  final Widget itemWidget;
  final List<HomeEntity> homeNavigationItems;
  HomeSwitchTabState({
    required this.homeNavigationItems,
    required this.itemWidget,
  });
}
