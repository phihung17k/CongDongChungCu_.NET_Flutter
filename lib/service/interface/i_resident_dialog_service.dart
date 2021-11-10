
import 'package:congdongchungcu/models/apartment_model.dart';
import 'package:congdongchungcu/models/building_model.dart';

abstract class IResidentDialogService{

  Future<List<ApartmentModel>> getAllApartment();

  Future<List<BuildingModel>> getAllBuilding();
}