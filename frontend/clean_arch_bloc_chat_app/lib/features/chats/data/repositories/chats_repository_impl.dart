import 'dart:async';
import 'dart:convert';

import 'package:clean_arch_bloc_chat_app/features/chats/data/models/chats_model.dart';
import 'package:clean_arch_bloc_chat_app/features/chats/domain/entities/chats_entity.dart';
import 'package:clean_arch_bloc_chat_app/features/chats/domain/repositories/chats_repository.dart';
import 'package:clean_arch_bloc_chat_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:http/http.dart' as http;

class ChatsRepositoryImpl implements ChatsRepository {
  final homeState = HomeState as HomeLoadedState;
  List<ChatsModel> dummyChatsData = [];

  getUserData() async {
    final url =
        Uri.parse("http://localhost:3000/get-user/${homeState.user!.id}");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final chatsList = jsonData["chats"];
      chatsList.forEach((chat) {
        print(chat);
      });
    } else {
      print("Request failed with status: ${response.statusCode}");
    }
  }

  @override
  Future<List<ChatsEntity>> getAllChats() async {
    getUserData();
    final result =
        dummyChatsData.map((chatData) => chatData.toEntity()).toList();
    return result;
  }
}
