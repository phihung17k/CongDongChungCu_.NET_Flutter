
import 'package:congdongchungcu/models/poi/poi_model.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapAdminState extends Equatable{
  final POIModel poi;
  final Marker poiMarker;
  final Marker selectedMarker;

  MapAdminState({this.poi, this.poiMarker, this.selectedMarker});

  MapAdminState copyWith({POIModel poi, Marker poiMarker, Marker selectedMarker}){
    return MapAdminState(
      poi: poi ?? this.poi,
      poiMarker: poiMarker ?? this.poiMarker,
      selectedMarker: selectedMarker ?? this.selectedMarker,
    );
  }

  @override
  List<Object> get props => [poi, poiMarker, selectedMarker];
}