
import 'dart:convert';
import 'dart:io';

import 'package:congdongchungcu/models/apartment_model.dart';
import 'package:congdongchungcu/models/building_model.dart';
import 'package:congdongchungcu/models/resident_model.dart';
import 'package:congdongchungcu/service/interface/i_services.dart';
import 'package:congdongchungcu/service/service_adapter.dart';
import 'package:http/http.dart' as http;

import '../api.dart';
import '../log.dart';

class SplashService implements ISplashService{
  ServiceAdapter adapter = ServiceAdapter();

  @override
  Future<ResidentModel> getResident(int residentId) async{
    var client = http.Client();
    String url = Api.getURL(apiPath: Api.residents);
    ResidentModel result;
    try {
      var response = await client.get(Uri.parse("$url/$residentId"));
      if (response.statusCode == 200) {
        Map<String, dynamic> dataMap = adapter.parseToMap(response);
        //result contains id, isAdmin
        String authToken = response.headers[HttpHeaders.authorizationHeader];
        String securityData = response.headers['security-data'];
        // print("securityData $securityData");
        Map<String, dynamic> securityMap = jsonDecode(securityData);
        Map<String, int> mapId = {
          "apartmentId": securityMap['ApartmentId'],
          "buildingId": securityMap['BuildingId']
        };
        result = ResidentModel.fromJson(dataMap, mapId: mapId);
        result.authToken = authToken;
      }
    } catch (e) {
      Log.e(e?.message);
    } finally {
      client.close();
    }
    return result;
  }

  @override
  Future<ApartmentModel> getApartment(int id) async {
    var client = http.Client();
    String url = Api.getURL(apiPath: Api.apartments);
    ApartmentModel result;
    try {
      var response = await client.get(Uri.parse("$url/$id"));
      if (response.statusCode == 200) {
        Map<String, dynamic> json = adapter.parseToMap(response);
        result = ApartmentModel.fromJson(json);
      }
    } catch (e) {
      Log.e(e);
    } finally {
      client.close();
    }
    return result;
  }

  @override
  Future<BuildingModel> getBuilding(int id) async {
    var client = http.Client();
    String url = Api.getURL(apiPath: Api.buildings);
    BuildingModel result;
    try {
      var response = await client.get(Uri.parse("$url/$id"));
      if (response.statusCode == 200) {
        Map<String, dynamic> json = adapter.parseToMap(response);
        result = BuildingModel.fromJson(json);
      }
    } catch (e) {
      Log.e(e);
    } finally {
      client.close();
    }
    return result;
  }
}