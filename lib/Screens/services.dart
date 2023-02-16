import 'package:flutter/material.dart';
import 'package:flutter_chat_gpt/Widget/drop_down_widget.dart';
import 'package:flutter_chat_gpt/constants/constructor.dart';

import '../Widget/text_widget.dart';


class Services {
  static Future<void> showModalSheet({required BuildContext context}) async {
    await showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        backgroundColor: cScafoaldbackground,
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Flexible(
                  child: TextWidget(
                    label: "Chosen Model:",
                    fontSize: 16,
                  ),
                ),
                Flexible(flex: 2, child: ModelsDropDown()),
              ],
            ),
          );
        });
  }
}
