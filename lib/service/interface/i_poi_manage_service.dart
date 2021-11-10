import 'package:congdongchungcu/models/paging_result_model.dart';
import 'package:congdongchungcu/models/poi/get_poi_model.dart';
import 'package:congdongchungcu/models/poi/poi_model.dart';
import 'package:congdongchungcu/models/poi/poi_type_model.dart';

abstract class IPoiManageService{
   Future<PagingResult<POIModel>> getPoiByCondition(GetPOIModel model);
   Future<List<POITypeModel>> getPoiType();
   Future<bool> deletePOI(POIModel deletePOI);
}