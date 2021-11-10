import 'package:intl/intl.dart';

class StoreDTO {
  int storeId;
  String name;
  DateTime openingTime;
  DateTime closingTime;
  String address;
  String phone;
  bool status;
  int apartmentId;
  int residentId;
  String ownerStore;

  StoreDTO(
      {this.storeId,
      this.name,
      this.openingTime,
      this.closingTime,
      this.address,
      this.phone,
      this.status,
      this.ownerStore});

  factory StoreDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) throw Exception("Json news model cannot null");

    String closeString = json['closing_time'];
    String openString = json['opening_time'];

    closeString = closeString.replaceAll("T", " ");
    closeString = closeString.replaceAll("Z", "");

    openString = openString.replaceAll("T", " ");
    openString = openString.replaceAll("Z", "");

    // DateTime closingTime = DateFormat("yyyy-MM-dd hh:mm:ss").parse(json['closing_time']);
    DateTime closingTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(closeString);

    // DateTime openingTime = DateFormat("yyyy-MM-dd hh:mm:ss").parse(json['opening_time']);
    DateTime openingTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(openString);

    return StoreDTO(
        storeId: json['store_id'],
        address: json['address'],
        closingTime: closingTime,
        name: json['name'],
        openingTime: openingTime,
        ownerStore: json['owner_store'],
        phone: json['phone'],
        status: json['status']);
  }

  // hàm này trả ra 1 object Model
  //trả ra 1 đối tượng product từ Map<Key,Value> của json['item']
  static StoreDTO fromJsonModel(Map<String, dynamic> json) =>
      StoreDTO.fromJson(json);
}
