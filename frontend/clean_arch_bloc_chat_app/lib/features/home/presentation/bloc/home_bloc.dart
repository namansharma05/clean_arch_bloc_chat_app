import 'package:clean_arch_bloc_chat_app/features/chats/presentation/bloc/chats_bloc.dart';
import 'package:clean_arch_bloc_chat_app/features/home/domain/entities/home_entity.dart';
import 'package:clean_arch_bloc_chat_app/features/home/domain/usecases/get_all_navigation_items.dart';
import 'package:clean_arch_bloc_chat_app/features/users/domain/entities/users_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetAllNavigationItems getAllNavigationItems;
  final ChatsBloc? chatsBloc;
  HomeBloc(this.getAllNavigationItems, this.chatsBloc) : super(HomeInitial()) {
    on<HomeGetAllNavigationItemsEvent>(homeGetAllNavigationItemsEvent);
    on<HomeSwitchTabEvent>(homeSwitchTabEvent);
  }

  Future<void> homeGetAllNavigationItemsEvent(
      HomeGetAllNavigationItemsEvent event, Emitter<HomeState> emit) async {
    print("inside home get all navigation items event");
    emit(HomeLoadingState());
    print(event.user);
    final homeNavigationItems = await getAllNavigationItems.call(event.user!);
    final initialContent = homeNavigationItems[0].itemWidget;
    chatsBloc!.add(ChatsGetAllEvent(user: event.user));
    emit(HomeLoadedState(
        homeNavigationItems: homeNavigationItems,
        initialContent: initialContent,
        user: event.user));
  }

  Future<void> homeSwitchTabEvent(
      HomeSwitchTabEvent event, Emitter<HomeState> emit) async {
    print('inside Home switch tab event');
    try {
      // Ensure homeNavigationitems is available (could be cached for optimization)
      final homeNavigationItems = await getAllNavigationItems.call(event.user!);
      final selectedWidget = homeNavigationItems[event.index].itemWidget;
      // Emit new state with the selected widget
      emit(HomeSwitchTabState(
          itemWidget: selectedWidget,
          homeNavigationItems: homeNavigationItems));
    } catch (e) {
      // Handle errors properly and emit an error state
      emit(HomeErrorState(error: e));
    }
  }
}
