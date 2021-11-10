import 'package:congdongchungcu/models/poi/poi_model.dart';
import 'package:congdongchungcu/service/interface/i_edit_poi_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../../base_bloc.dart';
import '../../firebase_utils.dart';
import 'edit_poi_event.dart';
import 'edit_poi_state.dart';

class EditPOIBloc extends BaseBloc<EditPOIEvent, EditPOIState> {
  final IEditPoiService service;

  EditPOIBloc(this.service)
      : super(EditPOIState(
            pickedFile: XFile(""),
            listPoiTypeEdit: [],
            poiReceive: POIModel(
              address: '',
              apartmentId: 1,
              id: 1,
              name: '',
              phone: '1732',
              poitype_id: 1,
              status: true,
              latitude: 0,
              longitude: 0,
              imagePath: '',
            ),
            isChanged: false,
  )) {
    on((event, emit) async {
      if (event is ReceiveDataFromPOIPage) {
        emit(state.copyWith(
            poiReceive: event.poiReceive, listPoiTypeEdit: event.listPoiType));
        print("poi receive bloc");
        print(state.poiReceive.imagePath);
      }
      if (event is SelectDropdownValue) {
        emit(state.copyWith(dropdownValue: event.dropdownValue));
        print(event.dropdownValue);
      }
      if (event is UpdatePOI) {
        bool result = await service.updatePoiByID(event.poiModelUpdate);
        print(result);
        if (!result) {
          print("update k thanh cong");
        }
      }
      if (event is ChooseImage) {
        // print(event.pickedFile.name);
        emit(state.copyWith(pickedFile: event.pickedFile));
      }
      if (event is UploadFileImageToFireBase) {
        String imageName = (state.poiReceive.id).toString();
        print(imageName);
        await FirebaseUtils.uploadFile(state.pickedFile.path, imageName, "poi");
      }
      if (event is NavigatorGoogleMapAdminEvent) {
        listener.add(NavigatorGoogleMapAdminEvent(model: event.model));
      }

      if (event is UpdateLatLngPOIEvent) {
        emit(state.copyWith(
          poiReceive: event.model,
          isChanged: !state.isChanged,
        ));
      }
    });
  }
}
