import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_gpt/Screens/api_services.dart';

import '../Models/chat_model.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> chatList = [];

  List<ChatModel> get getChatModel {
    return chatList;
  }

  void addUserMessage({required String msg}) {
    chatList.add(ChatModel(chatIndex: 0, msg: msg));
    notifyListeners();
  }

  Future<void> sendMessageAndGetAnswers(
      {required String msg, required String choisModelId}) async {
    chatList.addAll(
        await ApiService.sendMessage(message: msg, modelId: choisModelId));
    notifyListeners();
  }
}
