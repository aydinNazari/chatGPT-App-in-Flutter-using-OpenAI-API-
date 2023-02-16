import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_chat_gpt/Provider/models_provider.dart';
import 'package:flutter_chat_gpt/Screens/api_services.dart';
import 'package:flutter_chat_gpt/Screens/services.dart';
import 'package:flutter_chat_gpt/Widget/chat_widget.dart';
import 'package:flutter_chat_gpt/Widget/text_widget.dart';
import 'package:flutter_chat_gpt/constants/constructor.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../Models/chat_model.dart';
import '../Provider/chats_provider.dart';
import '../Services/assets_management.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isTyping = false;
  late TextEditingController textEditingController;
  late FocusNode focusNode;
  late ScrollController _listScrollController;

  @override
  void initState() {
    _listScrollController = ScrollController();
    focusNode = FocusNode();
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _listScrollController.dispose();
    focusNode.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  //List<ChatModel> chatList = [];

  @override
  Widget build(BuildContext context) {
    final modelProvider = Provider.of<ModelProvider>(context);
    final chatProvider = Provider.of<ChatProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ChatGPT'),
          actions: [
            IconButton(
              onPressed: () async {
                await Services.showModalSheet(context: context);
              },
              icon: const Icon(Icons.more_vert_rounded),
            ),
          ],
          elevation: 2,
          leading: Padding(
            padding: const EdgeInsets.all(0.8),
            child: Image.asset(AssetsManager.openaiLogo),
          ),
        ),
        body: Column(
          children: [
            Flexible(
              child: ListView.builder(
                controller: _listScrollController,
                itemCount: chatProvider.getChatModel.length,
                itemBuilder: (context, index) {
                  return ChatWidget(
                      msg: chatProvider.getChatModel[index].msg,
                      //chatList[index].msg,
                      chatIndex: chatProvider.getChatModel[index]
                          .chatIndex //chatList[index].chatIndex,
                      );
                },
              ),
            ),
            if (_isTyping) ...[
              const SpinKitThreeBounce(
                color: Colors.white,
                size: 18,
              )
            ],
            const SizedBox(
              height: 15,
            ),
            Material(
              color: cCard,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        focusNode: focusNode,
                        style: const TextStyle(color: Colors.white),
                        controller: textEditingController,
                        onSubmitted: (value) async {
                          await sendMessageFCT(
                              modelProvider: modelProvider,
                              chatProvider: chatProvider);
                        },
                        decoration: const InputDecoration(
                          hintText: 'How can I help you?',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await sendMessageFCT(
                            modelProvider: modelProvider,
                            chatProvider: chatProvider);
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void scrollListToEnd() {
    _listScrollController.animateTo(
        _listScrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 2),
        curve: Curves.easeOut);
  }

  Future<void> sendMessageFCT(
      {required ModelProvider modelProvider,
      required ChatProvider chatProvider}) async {
    String msg=textEditingController.text;
    if (textEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: TextWidget(
            label: 'Please type a message!',
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (_isTyping) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: TextWidget(
            label: 'You cant send mutiple messages at a time',
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    try {
      setState(() {
        _isTyping = true;
        //chatList.add(ChatModel(chatIndex: 0, msg: textEditingController.text));
        chatProvider.addUserMessage(msg: msg);
        textEditingController.clear();
        focusNode.unfocus();
      });
      await chatProvider.sendMessageAndGetAnswers(
          msg: msg,
          choisModelId: modelProvider.getcurrentModel);
      /*chatList.addAll(await ApiService.sendMessage(
          message: textEditingController.text,
          modelId: modelProvider.getcurrentModel));*/
      setState(() {});
    } catch (error) {
      log('error : $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: TextWidget(
            label: error.toString(),
          ),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isTyping = false;
        scrollListToEnd();
      });
    }
  }
}
