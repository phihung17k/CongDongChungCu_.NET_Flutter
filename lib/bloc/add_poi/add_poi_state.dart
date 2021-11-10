import 'package:congdongchungcu/models/poi/poi_type_model.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class AddPOIState extends Equatable {
  final List<POITypeModel> listPoiType;
  final int dropdownNewValue;
  final String name;
  final String address;
  final String phone;
  final XFile pickedFile;
  final double latitude;
  final double longitude;

  const AddPOIState({
    this.listPoiType,
    this.dropdownNewValue,
    this.name,
    this.address,
    this.phone,
    this.pickedFile,
    this.latitude,
    this.longitude,
  });

  AddPOIState copyWith({
    List<POITypeModel> listPoiType,
    int dropdownNewValue,
    String name,
    String phone,
    String address,
    XFile pickedFile,
    double latitude,
    double longitude,
  }) {
    return AddPOIState(
      listPoiType: listPoiType ?? this.listPoiType,
      dropdownNewValue: dropdownNewValue ?? this.dropdownNewValue,
      name: name ?? this.name,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      pickedFile: pickedFile ?? this.pickedFile,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [
        listPoiType,
        dropdownNewValue,
        name,
        address,
        phone,
        pickedFile,
        latitude,
        longitude
      ];
}
