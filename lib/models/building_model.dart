class BuildingModel {
  final int id;
  final String name;
  final int apartmentId;

  BuildingModel({this.id, this.name, this.apartmentId});

  factory BuildingModel.fromJson(Map<String, dynamic> json) {
    if (json == null) throw Exception("Json building model is null");
    int id = json['id'];
    String name = json['name'];
    int apartmentId = json['apartment_id'];
    bool status = json['status'];
    if(status) {
      return BuildingModel(
          id: id,
          name: name,
          apartmentId: apartmentId
      );
    }
    return null;
  }
}
