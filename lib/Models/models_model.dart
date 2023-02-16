class ModelsModel {
  final String id;
  final int created;
  final String root;

  ModelsModel({
    required this.id,
    required this.created,
    required this.root
  });

 /* factory ModelsModel.fromjson(Map<String, dynamic>json) =>
      ModelsModel(id: json['id'], root: json['babbage'], created: json['created']);
*/
  factory ModelsModel.fromjson(Map<String, dynamic> json) => ModelsModel(
    id: json["id"],
    root: json["root"],
    created: json["created"],
  );

  /*static List<ModelsModel> modelsFromSnapshot(List modelSnapshot){
    return modelSnapshot.map((data) => ModelsModel.fromjson(data)).toList();
  }*/
  static List<ModelsModel> modelsFromSnapshot(List modelSnapshot) {
    return modelSnapshot.map((data) => ModelsModel.fromjson(data)).toList();
  }

}