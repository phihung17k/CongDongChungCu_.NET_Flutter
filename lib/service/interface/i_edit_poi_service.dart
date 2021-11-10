import 'package:congdongchungcu/models/poi/poi_model.dart';
import 'package:congdongchungcu/models/poi/poi_type_model.dart';

abstract class IEditPoiService{
  Future<List<POITypeModel>> getListPoiType();
  Future<POITypeModel> getPOITypeByID(int poiID);
  Future<bool> updatePoiByID(POIModel poiUpdate);
}