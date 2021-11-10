
import 'package:congdongchungcu/models/poi/poi_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapAdminEvent{}

class GettingPOILocationEvent extends MapAdminEvent{
  final POIModel model;

  GettingPOILocationEvent({this.model});
}

class GettingYourLocationEvent extends MapAdminEvent{}

class CheckingLocationPermission extends MapAdminEvent{}

class BackToBeforePageEvent extends MapAdminEvent{}

class AddingMarkerEvent extends MapAdminEvent{
  final LatLng position;

  AddingMarkerEvent({this.position});
}

class MovingToSelectedMarker extends MapAdminEvent{
  final Marker selectedMarker;

  MovingToSelectedMarker({this.selectedMarker});
}

class SelectingMarker extends MapAdminEvent {
  final POIModel poi;

  SelectingMarker({this.poi});
}
