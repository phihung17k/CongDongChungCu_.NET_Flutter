
import 'package:congdongchungcu/base_bloc.dart';
import 'package:congdongchungcu/bloc/map_admin/map_admin_event.dart';
import 'package:congdongchungcu/bloc/map_admin/map_admin_state.dart';
import 'package:congdongchungcu/models/poi/poi_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../log.dart';

class MapAdminBloc extends BaseBloc<MapAdminEvent, MapAdminState>{
  MapAdminBloc() : super(MapAdminState()){
    on((event, emit) async{
      if (event is CheckingLocationPermission) {
        Position position = await checkPermission();
        if (position != null) {
        } else {
          listener.add(BackToBeforePageEvent());
        }
      } else if (event is GettingPOILocationEvent){
        POIModel model = event.model;
        Log.i("latitude ${model.latitude}");
        Log.i("longitude ${model.longitude}");
        emit(state.copyWith(
          poi: event.model,
          poiMarker: Marker(
            markerId: MarkerId("${model.latitude}, ${model.longitude}"),
            position: LatLng(model.latitude, model.longitude),
            infoWindow: InfoWindow(
              title: model.name,
              snippet: model.address,
            ),
          ),
        ));
      } else if (event is GettingYourLocationEvent) {
        Position position= await Geolocator.getCurrentPosition();
        POIModel poi = POIModel(
          latitude: position.latitude,
          longitude: position.longitude,
        );
        emit(state.copyWith(
          poi: poi,
          poiMarker: Marker(
            markerId: MarkerId("${position.latitude}, ${position.longitude}"),
            position: LatLng(position.latitude, position.longitude),
            infoWindow: const InfoWindow(
              title: "Vị trí của bạn",
            ),
          ),
        ));
      } else if (event is AddingMarkerEvent){
        LatLng position = event.position;
        Marker selectedMarker = Marker(
          markerId: MarkerId("${position.latitude}, ${position.longitude}"),
          position: position,
          infoWindow: const InfoWindow(
            title: "Vị trí mới"
          )
        );
        listener.add(MovingToSelectedMarker(
          selectedMarker: selectedMarker,
        ));
        emit(state.copyWith(
          selectedMarker: selectedMarker,
        ));
      } else if (event is SelectingMarker){
        if(state.selectedMarker != null){
          POIModel poi = state.poi;
          poi.latitude = state.selectedMarker.position.latitude;
          poi.longitude = state.selectedMarker.position.longitude;
          listener.add(SelectingMarker(
            poi: poi
          ));
        }
      }
    });
  }

  Future<Position> checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Log.i("Accept location permission");
      return await Geolocator.getCurrentPosition();
    }
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        Log.i("Accept location permission");
        return await Geolocator.getCurrentPosition();
      }
    }
    Log.i("Location permission is refused");
    return null;
  }
}