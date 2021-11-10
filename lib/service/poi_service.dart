import 'dart:convert';
import 'dart:io';

import 'package:congdongchungcu/models/paging_result_model.dart';
import 'package:congdongchungcu/models/poi/get_poi_model.dart';
import 'package:congdongchungcu/models/poi/poi_model.dart';
import 'package:congdongchungcu/models/poi/poi_type_model.dart';
import 'package:congdongchungcu/repository/user_repository.dart';
import 'package:congdongchungcu/service/interface/i_poi_service.dart';
import 'package:congdongchungcu/service/service_adapter.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import '../api.dart';
import '../log.dart';

class POIService extends IPoiService{
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
      url += "&current-page="+model.currPage.toString();
    }

    try {
      int apartmentID = GetIt.I.get<UserRepository>().selectedResident.apartmentId;
      var response = await client.get(Uri.parse(url), 
       headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "Security-Data": jsonEncode({"apartmentId": apartmentID}),
      });
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
}