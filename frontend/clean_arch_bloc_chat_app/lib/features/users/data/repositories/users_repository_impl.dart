import 'dart:convert';

import 'package:clean_arch_bloc_chat_app/features/users/data/models/users_model.dart';
import 'package:clean_arch_bloc_chat_app/features/users/domain/entities/users_entity.dart';
import 'package:clean_arch_bloc_chat_app/features/users/domain/repositories/users_repository.dart';
import 'package:http/http.dart' as http;

class UsersRepositoryImpl implements UsersRepository {
  getData() async {
    final url = Uri.parse("http://192.168.1.9:3000/get-users");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      // print(jsonData['result'][0].runtimeType);
      final List<UsersModel> result = [];
      jsonData["result"].forEach((item) {
        // print(item);
        final userModel = UsersModel.fromJson(item);
        // print(userModel.chats.runtimeType);
        result.add(userModel);
      });
      return result;
    } else {
      print("Request failed with status: ${response.statusCode}");
    }
  }

  @override
  Future<List<UsersEntity>> getAllUsers() async {
    final List<UsersModel> usersModel = await getData();
    // print(usersModel);
    final result = usersModel.map((userModel) => userModel.toEntity()).toList();
    return result;
  }
}
