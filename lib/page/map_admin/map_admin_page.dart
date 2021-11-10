import 'package:congdongchungcu/bloc/map_admin/map_admin_bloc.dart';
import 'package:congdongchungcu/bloc/map_admin/map_admin_event.dart';
import 'package:congdongchungcu/bloc/map_admin/map_admin_state.dart';
import 'package:congdongchungcu/models/poi/poi_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../app_colors.dart';

class MapAdminPage extends StatefulWidget {
  final MapAdminBloc bloc;

  MapAdminPage(this.bloc);

  @override
  _MapAdminPageState createState() => _MapAdminPageState();
}

class _MapAdminPageState extends State<MapAdminPage> {
  GoogleMapController mapController;

  MapAdminBloc get bloc => widget.bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.add(CheckingLocationPermission());

    bloc.listenerStream.listen((event) {
      if (event is BackToBeforePageEvent) {
        Navigator.of(context).pop();
      } else if (event is MovingToSelectedMarker){
        mapController.animateCamera(
          CameraUpdate.newLatLng(event.selectedMarker.position)
        );
      } else if (event is SelectingMarker){
        Navigator.of(context).pop(event.poi);
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
      bloc.add(GettingPOILocationEvent(model: model));
    } else {
      bloc.add(GettingYourLocationEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text("Vị trí điểm quan tâm"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          BlocBuilder<MapAdminBloc, MapAdminState>(
            bloc: bloc,
            builder: (context, state) {
              if (state.poiMarker != null) {
                return GoogleMap(
                  myLocationEnabled: true,
                  markers: state.selectedMarker == null ?
                  {state.poiMarker}
                  : {state.poiMarker, state.selectedMarker},
                  onMapCreated: (controller) {
                    mapController = controller;
                  },
                  initialCameraPosition: CameraPosition(
                    target: state.poiMarker.position,
                    zoom: 17.0,
                  ),
                  mapType: MapType.satellite,
                  onTap: (LatLng position) {
                    bloc.add(AddingMarkerEvent(
                      position: position,
                    ));
                  },
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          BlocBuilder<MapAdminBloc, MapAdminState>(
            bloc: bloc,
            builder: (context, state) {
              if(state.selectedMarker != null){
                return Positioned(
                  bottom: 10.0,
                  left: 60.0,
                  right: 60.0,
                  child: ElevatedButton(
                    onPressed: () {
                      bloc.add(SelectingMarker());
                    },
                    child: const Text("Chọn"),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }
}
