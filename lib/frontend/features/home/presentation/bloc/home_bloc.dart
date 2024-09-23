import 'dart:async';

import 'package:clean_arch_bloc_chat_app/frontend/features/home/domain/entities/home_entity.dart';
import 'package:clean_arch_bloc_chat_app/frontend/features/home/domain/usecases/get_all_navigation_items.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetAllNavigationItems getAllNavigationItems;
  HomeBloc(this.getAllNavigationItems) : super(HomeInitial()) {
    on<HomeGetAllNavigationItemsEvent>(homeGetAllNavigationItemsEvent);
    on<HomeSwitchToChatsEvent>(homeSwitchToChatsEvent);
    on<HomeSwitchToStatusEvent>(homeSwitchToStatusEvent);
  }

  Future<void> homeGetAllNavigationItemsEvent(
      HomeGetAllNavigationItemsEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    final homeNavigationitems = await getAllNavigationItems.call();
    emit(HomeLoadedState(homeNavigationitems: homeNavigationitems));
  }

  Future<void> homeSwitchToChatsEvent(
      HomeSwitchToChatsEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    emit(HomeSwitchToChatsState(index: 1));
  }

  FutureOr<void> homeSwitchToStatusEvent(
      HomeSwitchToStatusEvent event, Emitter<HomeState> emit) {
    emit(HomeLoadingState());
    emit(HomeSwitchToStatusState(index: 2));
  }
}
