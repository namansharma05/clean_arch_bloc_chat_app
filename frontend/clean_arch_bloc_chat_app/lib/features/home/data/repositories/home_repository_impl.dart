import 'package:clean_arch_bloc_chat_app/features/chats/presentation/pages/chats_page.dart';
import 'package:clean_arch_bloc_chat_app/features/home/data/models/home_model.dart';
import 'package:clean_arch_bloc_chat_app/features/home/domain/repositories/home_repository.dart';
import 'package:clean_arch_bloc_chat_app/features/users/domain/entities/users_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeRepositoryImpl implements HomeRepository {
  List<HomeModel> getItems(UsersEntity user) {
    List<HomeModel> navigationItems = [
      HomeModel(
        itemWidget: ChatsPage(user: user),
        itemIcon: const Icon(Icons.chat),
        itemName: 'Chats',
        itemIndex: 1,
      ),
      HomeModel(
        itemWidget: ChatsPage(user: user),
        itemIcon: const Icon(CupertinoIcons.arrow_2_circlepath_circle),
        itemName: 'Status',
        itemIndex: 2,
      ),
    ];
    return navigationItems;
  }

  @override
  Future<List<HomeModel>> getAllNavigationItems(UsersEntity user) async {
    return getItems(user);
  }
}
