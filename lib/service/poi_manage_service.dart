import 'dart:convert';
import 'dart:io';
import 'package:congdongchungcu/models/paging_result_model.dart';
import 'package:congdongchungcu/models/poi/get_poi_model.dart';
import 'package:congdongchungcu/models/poi/poi_model.dart';
import 'package:congdongchungcu/models/poi/poi_type_model.dart';
import 'package:congdongchungcu/repository/user_repository.dart';
import 'package:congdongchungcu/service/interface/i_poi_manage_service.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import '../api.dart';
import 'service_adapter.dart';

class POIMangeService extends IPoiManageService{
    ServiceAdapter adapter = ServiceAdapter();
    @override
  Future<PagingResult<POIModel>> getPoiByCondition(GetPOIModel model) async {
    var client = http.Client();
    String url = Api.getURL(apiPath: Api.poi);
    PagingResult<POIModel> pagingResult;
      if (model.name != null) {
      url += "?name=" + model.name;
      url += "&status=true";
    }else{
       url += "?status=true";
    }
    if (model.poiTypeId != null) {
      url += "&poitype-id=" + model.poiTypeId.toString();
    }else{
      url += "&poitype-id=0";
    }
    if(model.currPage > 0){
      url += "&current-page=" + model.currPage.toString();
    }

    try {
       int apartmentID = GetIt.I.get<UserRepository>().selectedResident.apartmentId;
      var response = await client.get(Uri.parse(url), 
      headers: { HttpHeaders.contentTypeHeader: "application/json",
        "Security-Data": jsonEncode({"apartmentId": apartmentID}),});
      if (response.statusCode == 200) {     
          Map<String, dynamic> pagingMap = adapter.parseToMap(response);
        pagingResult =
            PagingResult.fromJson(pagingMap, POIModel.fromJsonModel);
      }
    }
    catch (e) {
      // Log.e(e);
    }
     finally {
      client.close();
    }
   return pagingResult;
  }

  @override
  Future<List<POITypeModel>> getPoiType() async{
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
    }catch(e){

    }
    finally {
      client.close();
    }
   return listPoiType;
  }

    @override
  Future<bool> deletePOI(POIModel deletePOI) async {
    var client = http.Client();
    String url = Api.getURL(apiPath: Api.poi);
    String token = GetIt.I.get<UserRepository>().selectedResident.authToken;
    bool result = false;
    try {
      var response = await client.put(Uri.parse(url+"/${deletePOI.id}"), 
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
        'Content-Type': 'application/json; charset=UTF-8'
      }, 
      body: jsonEncode(<String, dynamic>{
        "name": deletePOI.name,
        "address": deletePOI.address,
        "phone": deletePOI.phone,
        "status": deletePOI.status,
        "poitype_id": deletePOI.poitype_id
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