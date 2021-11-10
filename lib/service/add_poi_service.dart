import 'dart:convert';
import 'dart:io';

import 'package:congdongchungcu/models/poi/poi_type_model.dart';
import 'package:congdongchungcu/repository/user_repository.dart';
import 'package:congdongchungcu/service/interface/i_add_poi_service.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import '../api.dart';
import 'service_adapter.dart';

class AddPOIService extends IAddPOIService {
  ServiceAdapter adapter = ServiceAdapter();

  @override
  Future<int> addPOI(
      {String name,
      String address,
      String phone,
      int poiTypeID,
      double latitude,
      double longitude}) async {
    var client = http.Client();
    String url = Api.getURL(apiPath: Api.poi);
    String token = GetIt.I.get<UserRepository>().selectedResident.authToken;
    int apartmentID =
        GetIt.I.get<UserRepository>().selectedResident.apartmentId;
    bool result = false;
    int responeID = -1;
    try {
      var response = await client.post(Uri.parse(url),
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
            'Content-Type': 'application/json; charset=UTF-8',
            "Security-Data": jsonEncode({"apartmentId": apartmentID}),
          },
          body: jsonEncode(<String, dynamic>{
            "name": name,
            "address": address,
            "phone": phone,
            "poitype_id": poiTypeID,
            "latitude": latitude,
            "longitude": longitude,
          }));
      print(response.statusCode);
      if (response.statusCode == 201) {
        print("Add thành công ha");
        Map<String, dynamic> responeResult = adapter.parseToMap(response);
        responeID = responeResult['id'];
      } else {
        print("Add k thanh cong");
      }
    } catch (e) {
    } finally {
      client.close();
    }
    return responeID;
  }

  @override
  Future<List<POITypeModel>> getPoiType() async {
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
}
