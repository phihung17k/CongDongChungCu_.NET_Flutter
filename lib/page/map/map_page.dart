import 'package:congdongchungcu/bloc/map/map_bloc.dart';
import 'package:congdongchungcu/bloc/map/map_event.dart';
import 'package:congdongchungcu/bloc/map/map_state.dart';
import 'package:congdongchungcu/models/poi/poi_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../app_colors.dart';

class MapPage extends StatefulWidget {
  final MapBloc bloc;

  MapPage(this.bloc);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController mapController;

  MapBloc get bloc => widget.bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.add(CheckingLocationPermission());
    bloc.listenerStream.listen((event) {
      if (event is BackToBeforePageEvent) {
        Navigator.of(context).pop();
      } else if (event is MovingCameraEvent){
        mapController.animateCamera(
          CameraUpdate.newLatLngBounds(
            LatLngBounds(
              northeast: event.northeast,
              southwest: event.southwest,
            ),
            100.0, // padding
          ),
        );
      }
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    RouteSettings settings = ModalRoute.of(context).settings;
    if (settings.arguments != null) {
      POIModel model = settings.arguments as POIModel;
      bloc.add(GettingDefaultLocationEvent(model: model));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text("Vị trí điểm quan tâm"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              bloc.add(DrawingPolyLineEvent());
            },
            icon: const Icon(Icons.motorcycle_sharp),
          ),
        ],
      ),
      body: BlocBuilder<MapBloc, MapState>(
        bloc: bloc,
        builder: (context, state) {
          if (state.yourMarker != null && state.poiMarker != null) {
            return GoogleMap(
              myLocationEnabled: true,
              markers: {
                state.poiMarker,
                state.yourMarker,
              },
              polylines: Set<Polyline>.of(state.polylines.values),
              onMapCreated: (controller) {
                mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: state.poiMarker.position,
                zoom: 15.0,
              ),
              mapType: MapType.satellite,
              onTap: (LatLng position) {
                // _bloc.addMarker(position);
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }
}
