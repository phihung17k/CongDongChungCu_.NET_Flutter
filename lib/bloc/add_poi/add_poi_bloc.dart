import 'package:congdongchungcu/bloc/add_poi/add_poi_event.dart';
import 'package:congdongchungcu/bloc/add_poi/add_poi_state.dart';
import 'package:congdongchungcu/models/poi/poi_model.dart';
import 'package:congdongchungcu/models/poi/poi_type_model.dart';
import 'package:congdongchungcu/service/interface/i_add_poi_service.dart';
import 'package:image_picker/image_picker.dart';

import '../../base_bloc.dart';
import '../../firebase_utils.dart';

class AddPOIBloc extends BaseBloc<AddPOIEvent, AddPOIState> {
  final IAddPOIService service;

  AddPOIBloc(this.service)
      : super(AddPOIState(listPoiType: [], pickedFile: XFile(""))) {
    on((event, emit) async {
      if (event is GetPOIType) {
        List<POITypeModel> listPOIType = await service.getPoiType();
        print(listPOIType);
        emit(state.copyWith(
            listPoiType: listPOIType, dropdownNewValue: listPOIType[0].id));
      }
      if (event is ChangeDropdownValue) {
        emit(state.copyWith(dropdownNewValue: event.dropdownNewValue));
      }
      if (event is GetPoiName) {
        emit(state.copyWith(name: event.name));
      }
      if (event is GetPoiAddress) {
        emit(state.copyWith(address: event.address));
      }
      if (event is GetPoiPhone) {
        emit(state.copyWith(phone: event.phone));
      }
      if (event is AddPOI) {
        int result = await service.addPOI(
          name: event.name,
          address: event.address,
          phone: event.phone,
          poiTypeID: event.poiTypeID,
          latitude: state.latitude,
          longitude: state.longitude,
        );
        print("result");
        print(result);
        if (result >= 0) {
          print("Add thanh cong");
          print("add poi bloc");
          print(result);
          await FirebaseUtils.uploadFile(
              state.pickedFile.path, result.toString(), "poi");
        } else {
          print("Add khong thanh cong roi");
        }
      }
      if (event is ChooseImage) {
        // print(event.pickedFile.name);
        emit(state.copyWith(pickedFile: event.pickedFile));
      }
      if (event is UploadFileImageFromAddToFireBase) {
        //   String imageName = (state.poiReceive.id).toString();
        // print(imageName);
        // await FirebaseUtils.uploadFile(state.pickedFile.path, imageName,"poi");
      }
      if (event is NavigatorGoogleMapAdminEvent) {
        if(state.latitude != null && state.longitude != null) {
          listener.add(NavigatorGoogleMapAdminEvent(
            model: POIModel(
              latitude: state.latitude,
              longitude: state.longitude,
            ),
          ));
        } else {
          listener.add(NavigatorGoogleMapAdminEvent());
        }
      } else if (event is UpdateLocationEvent){
        emit(state.copyWith(
          latitude: event.latitude,
          longitude: event.longitude,
        ));
      }
    });
  }
}
