import 'package:congdongchungcu/models/poi/get_poi_model.dart';
import 'package:congdongchungcu/models/poi/poi_model.dart';
import 'package:congdongchungcu/models/poi/poi_type_model.dart';

class POIEvent {}

class GetAllPOIEvent extends POIEvent {}

class SelectPOIEvent extends POIEvent {}

class SelectPOITypeEvent extends POIEvent {}

class SelectDropdownNewValue extends POIEvent {
  final POITypeModel dropdownNewValue;
  final GetPOIModel getPOIModel;

  SelectDropdownNewValue({this.dropdownNewValue, this.getPOIModel});
}

class NavigatorEditPOIEvent extends POIEvent {
  final POIModel poi;
  final List<POITypeModel> listPoiType;
  NavigatorEditPOIEvent({this.poi, this.listPoiType});
}

class InputSearchValue extends POIEvent{
  final String searchValue;
  final GetPOIModel getPOIModel;
  InputSearchValue({this.searchValue, this.getPOIModel});
}
class IncreaseNewsCurrPage extends POIEvent{}
class RefreshNews extends POIEvent{}

class NavigatorToGoogleMapEvent extends POIEvent{
  final POIModel model;

  NavigatorToGoogleMapEvent({this.model});
}