
import 'package:congdongchungcu/models/apartment_model.dart';
import 'package:congdongchungcu/models/building_model.dart';
import 'package:congdongchungcu/models/resident_model.dart';

abstract class ISplashService{

  Future<ResidentModel> getResident(int residentId);

  Future<ApartmentModel> getApartment(int id);

  Future<BuildingModel> getBuilding(int id);
}