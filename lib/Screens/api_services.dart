import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_chat_gpt/Models/chat_model.dart';
import 'package:flutter_chat_gpt/Models/models_model.dart';
import 'package:http/http.dart' as http;

import '../constants/api_constants.dart';

class ApiService {
  static Future<List<ModelsModel>> getModels() async {
    try {
      var response = await http.get(Uri.parse('$BASE_URL/models'),
          headers: {'Authorization': 'Bearer $API_KEY'});
      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        //print('error : ${jsonResponse['error']['message']}');
        throw HttpException(jsonResponse['error']['message']);
      }
      List temp = [];
      for (var value in jsonResponse['data']) {
        //log('temp : $value');
        temp.add(value);
      }
      return ModelsModel.modelsFromSnapshot(temp);
    } catch (error) {
      log('error : $error');
      rethrow;
    }
  }

  static Future<List<ChatModel>> sendMessage(
      {required String message, required String modelId}) async {
    log(' model issssssssssssss : $modelId');
    try {
      var response = await http.post(Uri.parse('$BASE_URL/completions'),
          headers: {
            'Authorization': 'Bearer $API_KEY',
            'Content-Type': 'application/json'
          },
          body: jsonEncode(
              {"model": modelId,
                "prompt": message,
                "max_tokens": 300,}));
      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        //print('error : ${jsonResponse['error']['message']}');
        throw HttpException(jsonResponse['error']['message']);
      }
      List<ChatModel> chatList = [];
      if (jsonResponse['choices'].length > 0) {
        //log('text : ${jsonResponse['choices'][0]['text']}');
        chatList = List.generate(
          jsonResponse['choices'].length,
          (index) => ChatModel(
            chatIndex: 1,
            msg: jsonResponse['choices'][index]['text'],
          ),
        );
      }
      return chatList;
    } catch (error) {
      log('error : $error');
      rethrow;
    }
  }
}
