import 'package:congdongchungcu/models/poi/get_poi_model.dart';
import 'package:congdongchungcu/models/poi/poi_model.dart';
import 'package:congdongchungcu/models/poi/poi_type_model.dart';

class POIManageEvent {}
class GetAllPOIEvent extends POIManageEvent {}

class SelectPOIEvent extends POIManageEvent {}

class SelectPOITypeEvent extends POIManageEvent {}

class SelectDropdownNewValue extends POIManageEvent {
  final POITypeModel dropdownNewValue;
  final GetPOIModel getPOIModel;

  SelectDropdownNewValue({this.dropdownNewValue, this.getPOIModel});
}

class NavigatorEditPOIEvent extends POIManageEvent {
  final POIModel poi;
  final List<POITypeModel> listPoiType;
  NavigatorEditPOIEvent({this.poi, this.listPoiType});
}

class InputSearchValue extends POIManageEvent{
  final String searchValue;
  final GetPOIModel getPOIModel;
  InputSearchValue({this.searchValue, this.getPOIModel});
}

class DeletePOI extends POIManageEvent{
  final POIModel poiModelDelete;
  DeletePOI({this.poiModelDelete});
}
class GetImageURLFromFireBase extends POIManageEvent{
  final String imageName;
  GetImageURLFromFireBase({this.imageName});
}
class IncreasePOICurrPage extends POIManageEvent{}

class RefreshPOI extends POIManageEvent{}

// class NavigatorGoogleMapAdminEvent extends POIManageEvent{
//   final POIModel model;
//
//   NavigatorGoogleMapAdminEvent({this.model});
// }
