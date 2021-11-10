import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapState extends Equatable {
  final Marker poiMarker;
  final Marker yourMarker;
  final Map<PolylineId, Polyline> polylines;

  MapState({this.poiMarker, this.yourMarker, this.polylines});

  MapState copyWith({
    Marker poiMarker,
    Marker yourMarker,
    Map<PolylineId, Polyline> polylines,
  }) {
    return MapState(
      poiMarker: poiMarker ?? this.poiMarker,
      yourMarker: yourMarker ?? this.yourMarker,
      polylines: polylines ?? this.polylines,
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [poiMarker, yourMarker, polylines];
}
