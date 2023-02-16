import 'package:flutter/material.dart';
import 'package:flutter_chat_gpt/Services/assets_management.dart';
import 'package:flutter_chat_gpt/Widget/text_widget.dart';
import 'package:flutter_chat_gpt/constants/constructor.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class ChatWidget extends StatelessWidget {
  final String msg;
  final int chatIndex;

  const ChatWidget({Key? key, required this.msg, required this.chatIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: chatIndex == 0 ? cScafoaldbackground : cCard,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  chatIndex == 0
                      ? AssetsManager.userImage
                      : AssetsManager.botImage,
                  width: 30,
                  height: 30,
                ),
                Expanded(
                  child: chatIndex == 0
                      ? TextWidget(label: msg)
                      : DefaultTextStyle(
                    style:const TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 16),
                        child: AnimatedTextKit(
                          repeatForever: false,
                            displayFullTextOnTap: true,
                            totalRepeatCount: 1,
                            animatedTexts: [
                              TyperAnimatedText(
                                msg.trim(),
                              ),
                            ],
                          ),
                      ),
                ),
                chatIndex == 0
                    ? const SizedBox.shrink()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.thumb_up_alt_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.thumb_down_alt_outlined,
                            color: Colors.white,
                          )
                        ],
                      )
              ],
            ),
          ),
        )
      ],
    );
  }
}
