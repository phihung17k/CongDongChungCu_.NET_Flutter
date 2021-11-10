
import 'package:congdongchungcu/models/poi/poi_model.dart';
import 'package:image_picker/image_picker.dart';

class AddPOIEvent{}
class AddPOI extends AddPOIEvent{
  final String address;
  final String name;
  final String phone;
  final int poiTypeID;
  final XFile pickedFile;

  AddPOI({this.name, this.address, this.phone, this.poiTypeID, this.pickedFile});
}

class GetPOIType extends AddPOIEvent{
}
class ChangeDropdownValue extends AddPOIEvent{
  final int dropdownNewValue;
  ChangeDropdownValue({this.dropdownNewValue});
}
class GetPoiName extends AddPOIEvent{
  final String name;
  GetPoiName({this.name});
}
class GetPoiAddress extends AddPOIEvent{
  final String address;
  GetPoiAddress({this.address});
}
class GetPoiPhone extends AddPOIEvent{
  final String phone;
  GetPoiPhone({this.phone});
}

class UploadFileImageFromAddToFireBase extends AddPOIEvent{
  final XFile pickedFile;
  UploadFileImageFromAddToFireBase({this.pickedFile});
}
class ChooseImage extends AddPOIEvent{
  final XFile pickedFile;
  ChooseImage({this.pickedFile});
}

class NavigatorGoogleMapAdminEvent extends AddPOIEvent{
  final POIModel model;

  NavigatorGoogleMapAdminEvent({this.model});
}

class UpdateLocationEvent extends AddPOIEvent{
  final double latitude;
  final double longitude;

  UpdateLocationEvent({this.latitude, this.longitude});
}