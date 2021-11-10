import '../../models/apartment_model.dart';
import '../../models/building_model.dart';

class ResidentModel {
  final int id;
  final bool isAdmin;
  final int apartmentId;
  final int buildingId;
  ApartmentModel apartmentModel;
  BuildingModel buildingModel;
  String authToken;

  ResidentModel(
      {this.id,
      this.isAdmin,
      this.apartmentId,
      this.buildingId,
      this.apartmentModel,
      this.buildingModel,
      this.authToken});

  factory ResidentModel.fromJson(Map<String, dynamic> json,
      {Map<String, int> mapId}) {
    if (json == null) throw Exception("Resident model json is null");
    int id = json['id'];
    bool isAdmin = json['isAdmin'];
    int apartmentId = json['apartmentId'] ?? mapId['apartmentId'];
    int buildingId = json['buildingId'] ?? mapId['buildingId'];
    return ResidentModel(
        id: id,
        isAdmin: isAdmin,
        apartmentId: apartmentId,
        buildingId: buildingId);
  }
}
