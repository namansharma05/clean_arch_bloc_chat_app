import 'package:clean_arch_bloc_chat_app/features/chats/presentation/pages/chats_page.dart';
import 'package:clean_arch_bloc_chat_app/features/home/data/models/home_model.dart';
import 'package:clean_arch_bloc_chat_app/features/home/domain/repositories/home_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeRepositoryImpl implements HomeRepository {
  List<HomeModel> navigationItems = [
    HomeModel(
      itemWidget: const ChatsPage(),
      itemIcon: Icon(Icons.chat),
      itemName: 'Chats',
      itemIndex: 1,
    ),
    HomeModel(
      itemWidget: const ChatsPage(),
      itemIcon: Icon(CupertinoIcons.arrow_2_circlepath_circle),
      itemName: 'Status',
      itemIndex: 2,
    ),
  ];
  @override
  Future<List<HomeModel>> getAllNavigationItems() async {
    return navigationItems;
  }
}
