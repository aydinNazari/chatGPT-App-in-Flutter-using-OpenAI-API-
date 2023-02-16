import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_gpt/Screens/api_services.dart';

import '../Models/models_model.dart';

class ModelProvider with ChangeNotifier {

  String currentModel = 'code-davinci-002';


  String get getcurrentModel {
    return currentModel;
  }
  void setCurrentModel(String newModel){
    currentModel=newModel;
    notifyListeners();
  }

  List<ModelsModel> modelList = [];
  List<ModelsModel> get getModelList {
    return modelList;
  }

  Future<List<ModelsModel>> getAllModels() async{
    modelList= await ApiService.getModels();
    return modelList;
  }
}
