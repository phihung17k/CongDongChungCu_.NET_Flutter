import 'dart:convert';
import 'dart:io';
import 'package:congdongchungcu/models/store_model.dart';
import 'package:congdongchungcu/models/store_model/get_store_codition.dart';
import 'package:congdongchungcu/models/store_model/get_store_model.dart';
import 'package:congdongchungcu/models/storedto_model.dart';
import 'package:congdongchungcu/repository/user_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import '../api.dart';
import '../log.dart';
import 'interface/i_services.dart';
import 'service_adapter.dart';
import 'package:http/http.dart' as http;

class StoreService implements IStoreService {
  ServiceAdapter adapter = ServiceAdapter();

  @override
  Future<StoreModel> getListStore(GetStoreModel request) async {
    var client = http.Client();
    String url = Api.getURL(apiPath: Api.store);
    //check request name of store
    if (request.NameOfStore != "") {
      url += "?name-of-store=" + request.NameOfStore;
    } else {
      url += "?current-page=" + request.currPage.toString();
    }

    // if(request.currPage != null && request.NameOfStore.length == 0)
    //   {
    //     url += "&current-page=" + request.currPage.toString();
    //   }

    //lấy apartment id của current
    int apartmentId =
        GetIt.I.get<UserRepository>().selectedResident.apartmentId;

    print(
        "đây là apartment id của resident hiện tại: " + apartmentId.toString());

    //print(url);

    try {
      var response = await client.get(Uri.parse(url),
          headers: {'Security-Data': '{"apartmentId" : ${apartmentId}}'});
      if (response.statusCode == 200) {
        // print('respone: ' + adapter.parseToString(response));
        Map<String, dynamic> result = adapter.parseToMap(response);
        var storeModel = StoreModel.fromJson(result);
        return storeModel;
      }
      if (response.statusCode == 200) {
        print('success');
      } else {
        print(response.statusCode);
        //print(authToken);
        print(url);
      }
    } finally {
      client.close();
    }
    return null;
  }

  @override
  Future<StoreDTO> addStore(StoreDTO model) async {
    // TODO: implement addProduct
    StoreDTO result;
    //lấy apartment id của current
    int apartmentId =
        GetIt.I.get<UserRepository>().selectedResident.apartmentId;

    int residentId = GetIt.I.get<UserRepository>().selectedResident.id;

    var client = http.Client();
    String url = Api.getURL(apiPath: Api.store);
    try {
      String openTime = DateFormat("yyyy-MM-dd HH:mm:ss").format(model.openingTime);
      String closeTime = DateFormat("yyyy-MM-dd HH:mm:ss").format(model.closingTime);

      openTime = formatTime(openTime);
      closeTime = formatTime(closeTime);
      var response = await client.post(Uri.parse(url),
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: jsonEncode(<String, dynamic>{
            "name": model.name,
            "opening_time": openTime,
            "closing_time": closeTime,
            "address": model.address,
            "phone": model.phone,
            "status": true,
            "apartment_id": apartmentId,
            "resident_id": residentId
          }));
      if (response.statusCode == 201) {
        print('success');
        Map<String, dynamic> json = adapter.parseToMap(response);
        result = StoreDTO.fromJson(json);
      } else {
        print(response.statusCode);
        //print(authToken);
        print(url);
      }
    } catch (e) {
      Log.e(e);
    } finally {
      client.close();
    }
    return result;
  }

  String formatTime(String time){
    String b = time.split(" ")[0];
    String c = time.split(" ")[1];
    return "${b}T${c}Z";
  }

  @override
  Future<bool> updateStore(StoreDTO model) async {
    // TODO: implement addProduct
    //
    int id = model.storeId;
    var client = http.Client();
    String url = Api.getURL(apiPath: Api.store + "/" + id.toString());
    try {

      String openTime = DateFormat("yyyy-MM-dd HH:mm:ss").format(model.openingTime);
      String closeTime = DateFormat("yyyy-MM-dd HH:mm:ss").format(model.closingTime);

      openTime = formatTime(openTime);
      closeTime = formatTime(closeTime);

      print("openTime $openTime ------- closeTime $closeTime");
      var response = await client.put(Uri.parse(url),
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: jsonEncode(<String, dynamic>{
            "name": model.name,
            "opening_time": openTime,
            "closing_time": closeTime,
            "address": model.address,
            "phone": model.phone,
            "status": true,
          }));
      if (response.statusCode == 200) {
        print('success');
        return true;
      } else {
        print(response.body);
        print(response.statusCode);
        print(url);
      }
    } catch (e) {
      Log.e(e);
    } finally {
      client.close();
    }
    return false;
  }

  @override
  Future<bool> deleteStore(StoreDTO model) async {
    // TODO: implement addProduct
    int id = model.storeId;

    var client = http.Client();
    String url = Api.getURL(apiPath: Api.store + "/" + id.toString());
    try {
      var response = await client.put(Uri.parse(url),
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: jsonEncode(<String, dynamic>{
            "name": model.name,
            "opening_time": DateFormat("yyyy-MM-dd").format(model.openingTime),
            "closing_time": DateFormat("yyyy-MM-dd").format(model.closingTime),
            "address": model.address,
            "phone": model.phone,
            "status": model.status,
          }));
      if (response.statusCode == 200) {
        print('success');
        return true;
      } else {
        print(response.statusCode);
        print(url);
      }
    } catch (e) {
      Log.e(e);
    } finally {
      client.close();
    }
    return false;
  }

  @override
  Future<StoreDTO> getStoreByCondition(GetStoreCondition request) async {
    var client = http.Client();
    String url = Api.getURL(apiPath: Api.store + "/" + "condition");

    if (request.residentId != null) {
      url += "?resident-id=" + request.residentId.toString();
    }

    if (request.storeId != null) {
      url += "?store-id=" + request.storeId.toString();
    }

    try {
      var response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // print('respone: ' + adapter.parseToString(response));
        Map<String, dynamic> result = adapter.parseToMap(response);
        var storeDTO = StoreDTO.fromJsonModel(result);

        print(
            "StoreId Service getBy condition: " + storeDTO.storeId.toString());

        return storeDTO;
      } else {
        print(url);
      }
    } finally {
      client.close();
    }
    return null;
  }
}
