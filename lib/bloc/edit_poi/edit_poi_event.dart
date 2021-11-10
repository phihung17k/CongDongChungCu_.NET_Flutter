import 'package:congdongchungcu/models/poi/poi_model.dart';
import 'package:congdongchungcu/models/poi/poi_type_model.dart';
import 'package:image_picker/image_picker.dart';

class EditPOIEvent{}
class ReceiveDataFromPOIPage extends EditPOIEvent{
  final POIModel poiReceive;
  final List<POITypeModel> listPoiType;
  ReceiveDataFromPOIPage({this.poiReceive, this.listPoiType});
}
 class SelectDropdownValue extends EditPOIEvent{
     final int dropdownValue;
     SelectDropdownValue({this.dropdownValue});
}
 class UpdatePOI extends EditPOIEvent{
   final POIModel poiModelUpdate;
   UpdatePOI({this.poiModelUpdate});
 }

 class ChooseImage extends EditPOIEvent{
   final XFile pickedFile;
   ChooseImage({this.pickedFile});
 }

 class UploadFileImageToFireBase extends EditPOIEvent{
   final XFile pickedFile;
   UploadFileImageToFireBase({this.pickedFile});
 }

class NavigatorGoogleMapAdminEvent extends EditPOIEvent{
  final POIModel model;

  NavigatorGoogleMapAdminEvent({this.model});
}

class UpdateLatLngPOIEvent extends EditPOIEvent{
  final POIModel model;

  UpdateLatLngPOIEvent({this.model});
}