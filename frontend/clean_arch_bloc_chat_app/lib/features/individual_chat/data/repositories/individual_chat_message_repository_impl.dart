import 'dart:convert';

import 'package:clean_arch_bloc_chat_app/features/individual_chat/data/models/individual_chat_message_model.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/domain/entities/individual_chat_message_entity.dart';
import 'package:clean_arch_bloc_chat_app/features/individual_chat/domain/respsitories/individual_chat_message_repository.dart';
import 'package:http/http.dart' as http;

class IndividualChatMessageRepositoryImpl
    implements IndividualChatMessageRepository {
  getChatMessages(int? userId, int? chatId) async {
    final url = Uri.parse("http://192.168.1.9:3000/get-user/$userId");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final chatsList = jsonData["user"]["chats"];
      Map<String, dynamic>? chatWithId = chatsList
          .firstWhere((chat) => chat['id'] == chatId, orElse: () => null);
      List<IndividualChatMessageModel> result = [];
      if (chatWithId != null) {
        chatWithId['messages'].forEach((message) =>
            result.add(IndividualChatMessageModel.fromJson(message)));
      }
      return result;
    } else {
      print("Request failed with status: ${response.statusCode}");
    }
  }

  addChatMessages(IndividualChatMessageEntity? newChatMessage) async {
    final url = Uri.parse("http://192.168.1.9:3000/add-message");
    final Map<String, dynamic> requestBody = {
      "senderId": newChatMessage!.senderId,
      "receiverId": newChatMessage.receiverId,
      "content": newChatMessage.content,
      "timeStamp": newChatMessage.timeStamp!.toIso8601String(),
    };
    final response = await http.post(url,
        headers: {'content-type': 'application/json'},
        body: jsonEncode(requestBody));
    if (response.statusCode == 200) {
      print("POST request successful: ${response.body}");
    } else {
      print("Failed with status: ${response.statusCode}");
    }
  }

  @override
  Future<List<IndividualChatMessageEntity>> getAllChatMessages(
      int? userId, int? chatId) async {
    List<IndividualChatMessageModel> chatMessages =
        await getChatMessages(userId, chatId);
    final result = chatMessages.map((individualChatMessage) {
      return individualChatMessage.toEntity();
    }).toList();
    return result;
  }

  @override
  Future<void> addNewChatMessage(
      IndividualChatMessageEntity? newChatMessage) async {
    addChatMessages(newChatMessage);
  }
}
