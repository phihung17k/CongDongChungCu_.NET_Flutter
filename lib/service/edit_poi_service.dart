import 'dart:convert';
import 'dart:io';

import 'package:congdongchungcu/bloc/edit_poi/edit_poi_event.dart';
import 'package:congdongchungcu/models/poi/poi_model.dart';
import 'package:congdongchungcu/models/poi/poi_type_model.dart';
import 'package:congdongchungcu/repository/user_repository.dart';
import 'package:congdongchungcu/service/interface/i_edit_poi_service.dart';
import 'package:congdongchungcu/service/service_adapter.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import '../api.dart';
import '../log.dart';

class EditPoiService extends IEditPoiService {
  ServiceAdapter adapter = ServiceAdapter();
  @override
  Future<List<POITypeModel>> getListPoiType() async {
    var client = http.Client();
    String url = Api.getURL(apiPath: Api.poiType);
    List<POITypeModel> listPoiType = [];
    Map<String, dynamic> result;
    try {
      var response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> list = adapter.parseToList(response);
        if (list.isNotEmpty) {
          list.forEach((poiTypeModel) {
            listPoiType.add(
                POITypeModel.fromJson(poiTypeModel as Map<String, dynamic>));
          });
        }
      }
    } catch (e) {
    } finally {
      client.close();
    }
    return listPoiType;
  }

  @override
  Future<POITypeModel> getPOITypeByID(int poiID) async {
    var client = http.Client();
    String url = Api.getURL(apiPath: Api.poiType);
    url += "/${poiID}";
    POITypeModel poiType;
    try {
      var response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map<String, dynamic> poiTypeMap = adapter.parseToMap(response);
        //  print(list[0]);
        if (poiTypeMap.isNotEmpty) {
          poiType = POITypeModel.fromJson(poiTypeMap);
          print("service");
          print(poiType.id);
        }
      }
    } catch (e) {
    } finally {
      client.close();
    }
    return poiType;
  }

  @override
  Future<bool> updatePoiByID(POIModel updatePoi) async {
    var client = http.Client();
    String url = Api.getURL(apiPath: Api.poi);
    String token = GetIt.I.get<UserRepository>().selectedResident.authToken;
    bool result = false;
    try {
      var response = await client.put(Uri.parse(url+"/${updatePoi.id}"), 
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
        'Content-Type': 'application/json; charset=UTF-8'
      }, 
      body: jsonEncode(<String, dynamic>{
        "name": updatePoi.name,
        "address": updatePoi.address,
        "phone": updatePoi.phone,
        "status": updatePoi.status,
        "latitude": updatePoi.latitude,
        "longitude": updatePoi.longitude,
        "poitype_id": updatePoi.poitype_id
      }));
      print(response.statusCode);
      if (response.statusCode == 200) {
        print("Update thành công ha");
        result = true;
      }
    } catch (e) {
    } finally {
      client.close();
    }
    return result;
  }
}
