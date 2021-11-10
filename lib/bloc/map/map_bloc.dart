import 'package:congdongchungcu/api.dart';
import 'package:congdongchungcu/base_bloc.dart';
import 'package:congdongchungcu/bloc/map/map_event.dart';
import 'package:congdongchungcu/bloc/map/map_state.dart';
import 'package:congdongchungcu/log.dart';
import 'package:congdongchungcu/models/poi/poi_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapBloc extends BaseBloc<MapEvent, MapState> {
  MapBloc() : super(MapState(
    polylines: {},
  )) {
    on((event, emit) async {
      if (event is CheckingLocationPermission) {
        Position position = await checkPermission();
        if (position != null) {
          emit(state.copyWith(
            yourMarker: Marker(
              markerId: MarkerId("${position.latitude}, ${position.longitude}"),
              position: LatLng(position.latitude, position.longitude),
              infoWindow: const InfoWindow(
                title: "Vị trí của bạn",
              ),
            ),
          ));
        } else {
          listener.add(BackToBeforePageEvent());
        }
      } else if (event is GettingDefaultLocationEvent) {
        POIModel model = event.model;
        Log.i("latitude ${model.latitude}");
        Log.i("longitude ${model.longitude}");
        emit(state.copyWith(
          poiMarker: Marker(
            markerId: MarkerId("${model.latitude}, ${model.longitude}"),
            position: LatLng(model.latitude, model.longitude),
            infoWindow: InfoWindow(
              title: model.name,
              snippet: model.address,
            ),
          ),
        ));
      } else if (event is DrawingPolyLineEvent) {
        LatLng yourPosition = state.yourMarker.position;
        LatLng poiPosition = state.poiMarker.position;

        double startLatitude = yourPosition.latitude;
        double startLongitude = yourPosition.longitude;

        double destinationLatitude = poiPosition.latitude;
        double destinationLongitude = poiPosition.longitude;

        double miny = (startLatitude <= destinationLatitude)
            ? startLatitude
            : destinationLatitude;
        double minx = (startLongitude <= destinationLongitude)
            ? startLongitude
            : destinationLongitude;
        double maxy = (startLatitude <= destinationLatitude)
            ? destinationLatitude
            : startLatitude;
        double maxx = (startLongitude <= destinationLongitude)
            ? destinationLongitude
            : startLongitude;

        double southWestLatitude = miny;
        double southWestLongitude = minx;

        double northEastLatitude = maxy;
        double northEastLongitude = maxx;

        LatLng northeast = LatLng(northEastLatitude, northEastLongitude);
        LatLng southwest = LatLng(southWestLatitude, southWestLongitude);
        listener.add(MovingCameraEvent(
          northeast: northeast,
          southwest: southwest,
        ));

        List<LatLng> polylineCoordinates = await createPolylines(
          startLatitude: startLatitude,
          startLongitude: startLongitude,
          destinationLatitude: destinationLatitude,
          destinationLongitude: destinationLongitude,
        );

        if(polylineCoordinates.isNotEmpty){
          Map<PolylineId, Polyline> polylines = {};
          PolylineId id = const PolylineId('poly');
          Polyline polyline = Polyline(
            polylineId: id,
            color: Colors.blue,
            points: polylineCoordinates,
            width: 3,
          );
          polylines[id] = polyline;
          emit(state.copyWith(
            polylines: polylines,
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

  Future<List<LatLng>> createPolylines({
    double startLatitude,
    double startLongitude,
    double destinationLatitude,
    double destinationLongitude,
  }) async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      Api.googleAPIKey,
      PointLatLng(startLatitude, startLongitude),
      PointLatLng(destinationLatitude, destinationLongitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    return polylineCoordinates;
  }
}
