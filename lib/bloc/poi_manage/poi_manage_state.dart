import 'package:congdongchungcu/models/poi/get_poi_model.dart';
import 'package:congdongchungcu/models/poi/poi_model.dart';
import 'package:congdongchungcu/models/poi/poi_type_model.dart';
import 'package:equatable/equatable.dart';

class POIManageState extends Equatable {
  final List<POIModel> currentListPoi;
  final List<POITypeModel> listPoiType;
  final GetPOIModel getPoiModel;
  final bool hasNext;
  final POITypeModel dropdownValue;

  const POIManageState(
      {this.currentListPoi,
      this.getPoiModel,
      this.hasNext,
      this.listPoiType,
      this.dropdownValue,});

  POIManageState copyWith(
      {List<POIModel> currentListPoi,
      GetPOIModel getPoiModel,
      bool hasNext,
      List<POITypeModel> listPoiType,
      POITypeModel dropdownValue,}) {
    return POIManageState(
        currentListPoi: currentListPoi ?? this.currentListPoi,
        getPoiModel: getPoiModel ?? this.getPoiModel,
        hasNext: hasNext ?? this.hasNext,
        listPoiType: listPoiType ?? this.listPoiType,
        dropdownValue: dropdownValue ?? this.dropdownValue);
  }

  @override
  // TODO: implement props
  List<Object> get props => [
        currentListPoi,
        getPoiModel,
        hasNext,
        listPoiType,
        dropdownValue,
      ];
}
