import 'dart:ui';

import 'package:congdongchungcu/models/poi/poi_model.dart';
import 'package:congdongchungcu/models/poi/poi_type_model.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class EditPOIState extends Equatable {
  final POIModel poiReceive;
  final List<POITypeModel> listPoiTypeEdit;
  final int dropdownValue;
  final XFile pickedFile;
  final bool isChanged;

  const EditPOIState(
      {this.poiReceive,
      this.listPoiTypeEdit,
      this.dropdownValue,
      this.pickedFile,
      this.isChanged});

  EditPOIState copyWith(
      {POIModel poiReceive,
      List<POITypeModel> listPoiTypeEdit,
      int dropdownValue,
      XFile pickedFile,
      bool isChanged}) {
    return EditPOIState(
      poiReceive: poiReceive ?? this.poiReceive,
      listPoiTypeEdit: listPoiTypeEdit ?? this.listPoiTypeEdit,
      dropdownValue: dropdownValue ?? this.dropdownValue,
      pickedFile: pickedFile ?? this.pickedFile,
      isChanged: isChanged ?? this.isChanged,
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [poiReceive, dropdownValue, pickedFile, isChanged];
}
