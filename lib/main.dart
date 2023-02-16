import 'package:flutter/material.dart';
import 'package:flutter_chat_gpt/Provider/chats_provider.dart';
import 'package:flutter_chat_gpt/Screens/chat_screen.dart';
import 'package:flutter_chat_gpt/constants/constructor.dart';
import 'package:provider/provider.dart';

import 'Provider/models_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ModelProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
        )
      ],
      child: MaterialApp(
        title: 'ChatGPT',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(color: cCard),
          scaffoldBackgroundColor: cScafoaldbackground,
          primarySwatch: Colors.blue,
        ),
        home: const ChatScreen(),
      ),
    );
  }
}
