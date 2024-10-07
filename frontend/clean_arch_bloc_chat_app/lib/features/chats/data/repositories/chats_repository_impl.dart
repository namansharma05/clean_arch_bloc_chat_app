import 'dart:async';
import 'dart:convert';

import 'package:clean_arch_bloc_chat_app/features/chats/data/models/chats_model.dart';
import 'package:clean_arch_bloc_chat_app/features/chats/domain/entities/chats_entity.dart';
import 'package:clean_arch_bloc_chat_app/features/chats/domain/repositories/chats_repository.dart';
import 'package:http/http.dart' as http;

class ChatsRepositoryImpl implements ChatsRepository {
  // final homeState = HomeState as HomeLoadedState;

  getUserData(int? userId) async {
    print("user id inside chats repository impl: ${userId}");
    final url = Uri.parse("http://192.168.1.9:3000/get-user/$userId");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      // print(jsonData);
      final chatsList = jsonData["user"]["chats"];
      // print("chatsList type: ${chatsList.runtimeType}");
      List<ChatsModel> result = [];
      chatsList.forEach((chat) => result.add(ChatsModel.fromJson(chat)));
      return result;
    } else {
      print("Request failed with status: ${response.statusCode}");
    }
  }

  @override
  Future<List<ChatsEntity>> getAllChats(int? userId) async {
    print("inside get all chats in chats repository impl");
    List<ChatsModel> chatsData = await getUserData(userId);
    print(chatsData);
    final result = chatsData.map((chatData) => chatData.toEntity()).toList();
    return result;
  }
}
