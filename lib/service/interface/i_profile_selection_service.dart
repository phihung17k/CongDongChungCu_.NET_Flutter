import '../../models/building_model.dart';
import '../../models/apartment_model.dart';
import '../../models/resident_model.dart';

abstract class IProfileSelectionService{
  Future<List<ResidentModel>> getResidents(int userId);

  Future<ApartmentModel> getApartment(int id);

  Future<BuildingModel> getBuilding(int id);

  Future addResident(Map<String, int> mapId);

  Future<String> getAuthToken(int residentId);
}