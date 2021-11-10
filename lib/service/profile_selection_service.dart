import 'dart:convert';
import 'dart:io';
import 'package:congdongchungcu/models/apartment_model.dart';
import 'package:congdongchungcu/models/building_model.dart';
import 'package:get_it/get_it.dart';
import '../log.dart';
import '../repository/user_repository.dart';
import 'package:http/http.dart' as http;
import '../api.dart';
import '../models/resident_model.dart';
import 'interface/i_services.dart';
import 'service_adapter.dart';

class ProfileSelectionService extends IProfileSelectionService {
  ServiceAdapter adapter = ServiceAdapter();

  @override
  Future<List<ResidentModel>> getResidents(int userId) async {
    var client = http.Client();
    String url = Api.getURL(apiPath: Api.residents);
    List<ResidentModel> result = [];
    try {
      UserRepository user = GetIt.I.get<UserRepository>();
      var response = await client.get(Uri.parse("$url?status=true"), headers: {
        HttpHeaders.authorizationHeader: "Bearer ${user.idToken}",
        "Security-Data": jsonEncode({"UserId": userId})
      });
      if (response.statusCode == 200) {
        List<dynamic> list = adapter.parseToList(response);
        if (list.isNotEmpty) {
          list.forEach((residentJson) {
            //id, isAdmin, apartmentId, buildingId
            result.add(
                ResidentModel.fromJson(residentJson as Map<String, dynamic>));
          });
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

  @override
  Future addResident(Map<String, int> mapId) async{
    var client = http.Client();
    String url = Api.getURL(apiPath: Api.residents);
    ResidentModel result;
    try {
      UserRepository user = GetIt.I.get<UserRepository>();
      var response = await client.post(Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          "Security-Data": jsonEncode({"UserId": user.id})
        },
        body: jsonEncode(<String, int>{
          "buildingId": mapId["buildingId"],
          "apartmentId": mapId["apartmentId"]
        }),
      );
      if (response.statusCode == 201) {
        Map<String, dynamic> json = adapter.parseToMap(response);
        result = ResidentModel.fromJson(json, mapId: mapId);
        // user.authToken = response.headers[HttpHeaders.authorizationHeader];
      }
    } catch (e) {
      Log.e(e);
    } finally {
      client.close();
    }
    return result;
  }

  @override
  Future<String> getAuthToken(int residentId) async{
    var client = http.Client();
    String url = Api.getURL(apiPath: Api.residents);
    String result = "";
    try {
      var response = await client.get(Uri.parse("$url/$residentId"));
      if (response.statusCode == 200) {
        adapter.parseToMap(response);
        result = response.headers[HttpHeaders.authorizationHeader];
        // result = ResidentModel.fromJson(json, mapId: mapId);
        // user.authToken = response.headers[HttpHeaders.authorizationHeader];
      }
    } catch (e) {
      Log.e(e);
    } finally {
      client.close();
    }
    return result;
  }
}
