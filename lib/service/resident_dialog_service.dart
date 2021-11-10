import 'package:congdongchungcu/models/apartment_model.dart';
import 'package:congdongchungcu/models/building_model.dart';
import 'package:congdongchungcu/service/interface/i_resident_dialog_service.dart';
import 'package:congdongchungcu/service/service_adapter.dart';
import 'package:http/http.dart' as http;

import '../api.dart';
import '../log.dart';

class ResidentDialogService implements IResidentDialogService{
  ServiceAdapter adapter = ServiceAdapter();

  @override
  Future<List<ApartmentModel>> getAllApartment() async {
    var client = http.Client();
    String url = Api.getURL(apiPath: Api.apartments);
    List<ApartmentModel> result = [];
    try {
      var response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> list = adapter.parseToList(response);
        for (dynamic apartment in list) {
          ApartmentModel apartmentModel =
            ApartmentModel.fromJson(apartment as Map<String, dynamic>);
          if (apartmentModel != null) {
            result.add(apartmentModel);
          }
        }
      }
    } catch (e) {
      Log.e(e);
    } finally {
      client.close();
    }
    return result;
  }

  @override
  Future<List<BuildingModel>> getAllBuilding() async {
    var client = http.Client();
    String url = Api.getURL(apiPath: Api.buildings);
    List<BuildingModel> result = [];
    try {
      var response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> list = adapter.parseToList(response);
        for (dynamic building in list) {
          BuildingModel buildingModel =
          BuildingModel.fromJson(building as Map<String, dynamic>);
          if (buildingModel != null) {
            result.add(buildingModel);
          }
        }
      }
    } catch (e) {
      Log.e(e);
    } finally {
      client.close();
    }
    return result;
  }
}