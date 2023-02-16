import 'package:flutter/material.dart';
import 'package:flutter_chat_gpt/Models/models_model.dart';
import 'package:flutter_chat_gpt/Screens/api_services.dart';
import 'package:flutter_chat_gpt/Widget/text_widget.dart';
import 'package:provider/provider.dart';

import '../Provider/models_provider.dart';
import '../constants/constructor.dart';

class ModelsDropDown extends StatefulWidget {
  const ModelsDropDown({Key? key}) : super(key: key);

  @override
  State<ModelsDropDown> createState() => _ModelsDropDownState();
}

class _ModelsDropDownState extends State<ModelsDropDown> {
  String? currentModel;

  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelProvider>(context, listen: false);
    currentModel = modelsProvider.getcurrentModel;
    return FutureBuilder<List<ModelsModel>>(
        future: modelsProvider.getAllModels(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return TextWidget(label: snapshot.error.toString());
          }
          return snapshot.data == null || snapshot.data!.isEmpty
              ? const SizedBox.shrink()
              : FittedBox(
                  child: DropdownButton(
                    dropdownColor: cScafoaldbackground,
                    iconEnabledColor: Colors.white,
                    iconDisabledColor: Colors.grey,
                    items: List<DropdownMenuItem<String>>.generate(
                      snapshot.data!.length,
                      (index) => DropdownMenuItem(
                        value: snapshot.data![index].id,
                        child: TextWidget(
                          label: snapshot.data![index].id,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    value: currentModel,
                    onChanged: (value) {
                      setState(
                        () {
                          currentModel = value.toString();
                        },
                      );
                      modelsProvider.setCurrentModel(value.toString());
                    },
                  ),
                );
        });
  }
}

/* DropdownButton(
      dropdownColor: cScafoaldbackground,
      iconEnabledColor: Colors.white,
      iconDisabledColor: Colors.grey,
      items: getModelsItem,
      value: currentModel,
      onChanged: (value) {
        setState(
          () {
            currentModel=value.toString();
          },
        );
      },
    );*/
