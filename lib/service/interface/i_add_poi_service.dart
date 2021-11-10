import 'package:congdongchungcu/models/poi/poi_type_model.dart';

abstract class IAddPOIService {
  Future<int> addPOI(
      {String name,
      String address,
      String phone,
      int poiTypeID,
      double latitude,
      double longitude});

  Future<List<POITypeModel>> getPoiType();
}
