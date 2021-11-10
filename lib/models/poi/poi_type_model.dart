class POITypeModel {
  int id;
  String name;

  POITypeModel({this.id, this.name});

  factory POITypeModel.fromJson(Map<String, dynamic> json) {
    if (json == null) throw Exception("Json news model cannot null");
    int id = json['id'];
    String name = json['name'];
    return POITypeModel(
      id: id,
      name: name,
    );
  }

  static POITypeModel fromJsonModel(Map<String, dynamic> json) => POITypeModel.fromJson(json);
}