class POIModel{
  int id;
  String name;
  String address;
  String phone;
  bool status;
  int poitype_id;
  int apartmentId;
  double latitude;
  double longitude;
  String imagePath;

  POIModel(
      {this.id,
      this.name,
      this.address,
      this.phone,
      this.status,
      this.poitype_id,
      this.apartmentId,
      this.latitude,
      this.longitude,
      this.imagePath});

  factory POIModel.fromJson(Map<String, dynamic> json) {
    if (json == null) throw Exception("Json news model cannot null");
    int id = json['id'];
    String name = json['name'];
    String address = json['address'];
    String phone = json['phone'];
    bool status = json['status'];
    int poitype_id = json['poitype_id'];
    int apartmentId = json['apartment_id'];
    double latitude = json['latitude'];
    double longitude = json['longitude'];
    return POIModel(
        id: id,
        name: name,
        address: address,
        phone: phone,
        status: status,
        poitype_id: poitype_id,
        apartmentId: apartmentId,
        latitude: latitude,
        longitude: longitude);
  }

  static POIModel fromJsonModel(Map<String, dynamic> json) =>
      POIModel.fromJson(json);
}
