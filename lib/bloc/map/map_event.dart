
import 'package:congdongchungcu/models/poi/poi_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapEvent {}

class GettingDefaultLocationEvent extends MapEvent{
  final POIModel model;

  GettingDefaultLocationEvent({this.model});
}

class CheckingLocationPermission extends MapEvent{}

class BackToBeforePageEvent extends MapEvent{}

class DrawingPolyLineEvent extends MapEvent{}

class MovingCameraEvent extends MapEvent{
  final LatLng northeast;
  final LatLng southwest;

  MovingCameraEvent({this.northeast, this.southwest});
}