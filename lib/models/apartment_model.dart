
class ApartmentModel {
  final int id;
  final String name;
  final String address;

  ApartmentModel({this.id, this.name, this.address});

  factory ApartmentModel.fromJson(Map<String, dynamic> json){
    if(json == null) throw Exception("Apartment model json is null");
    int id = json['id'];
    String name = json['name'];
    String address = json['address'];
    bool status = json['status'];
    if(status) {
      return ApartmentModel(
          id: id,
          name: name,
          address: address
      );
    }
    return null;
  }
}