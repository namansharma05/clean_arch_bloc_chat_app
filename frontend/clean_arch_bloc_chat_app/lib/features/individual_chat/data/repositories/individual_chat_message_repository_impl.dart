import 'dart:convert';

import 'package:clean_arch_bloc_chat_app/features/individual_chat/data/models/individual_chat_message_model.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/domain/entities/individual_chat_message_entity.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/domain/respsitories/individual_chat_message_repository.dart';
import 'package:http/http.dart' as http;

class IndividualChatMessageRepositoryImpl
    implements IndividualChatMessageRepository {
  getChatMessages(int? userId, int? chatId) async {
    print("user id inside chats repository impl: ${userId}");
    final url = Uri.parse("http://localhost:3000/get-user/$userId");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      // print(jsonData);
      final chatsList = jsonData["user"]["chats"];
      Map<String, dynamic>? chatWithId = chatsList
          .firstWhere((chat) => chat['id'] == chatId, orElse: () => null);
      List<IndividualChatMessageModel> result = [];
      if (chatWithId != null) {
        chatWithId['messages'].forEach((message) =>
            result.add(IndividualChatMessageModel.fromJson(message)));
        // chatWithId['messages'].forEach((e) => print(e.runtimeType));
      }
      return result;
    } else {
      print("Request failed with status: ${response.statusCode}");
    }
  }

  @override
  Future<List<IndividualChatMessageEntity>> getAllChatMessages(
      int? userId, int? chatId) async {
    List<IndividualChatMessageModel> chatMessages =
        await getChatMessages(userId, chatId);
    final result = chatMessages.map((individualChatMessage) {
      // print(individualChatMessage.runtimeType);
      // print('individual chat message type is: ${individualChatMessage.senderId}');
      // print('individual chat message is: ${individualChatMessage.receiverId}');
      // print(
      //     'individual chat messagetime is: ${individualChatMessage.content}');
      return individualChatMessage.toEntity();
    }).toList();
    return result;
  }

  @override
  Future<void> addNewChatMessage(
      IndividualChatMessageEntity? newChatMessage) async {
    print('inside add new chat message');
    // chatMessages.add(IndividualChatMessageModel.fromEntity(newChatMessage!));
    // chatMessages.forEach(print);
  }
}
