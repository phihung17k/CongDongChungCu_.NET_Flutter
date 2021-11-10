import 'package:congdongchungcu/models/apartment_model.dart';
import 'package:congdongchungcu/models/building_model.dart';
import 'package:congdongchungcu/models/resident_model.dart';
import 'package:congdongchungcu/repository/user_repository.dart';
import 'package:congdongchungcu/service/interface/i_services.dart';
import 'package:get_it/get_it.dart';

import '../../base_bloc.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends BaseBloc<SplashEvent, SplashState> {
  final ISplashService service;

  SplashBloc(this.service) : super(SplashState(opacity: 0)) {
    on((event, emit) async {
      if (event is SplashEvent) {
        emit(state.copyWith(opacity: 1));
      }
      if (event is InitiatingUserEvent) {
        ResidentModel residentModel =
            await service.getResident(event.residentId);
        ApartmentModel apartment =
            await service.getApartment(residentModel.apartmentId);
        BuildingModel building =
            await service.getBuilding(residentModel.buildingId);
        residentModel.apartmentModel = apartment;
        residentModel.buildingModel = building;
        // //save selected resident
        GetIt.I.get<UserRepository>().selectedResident = residentModel;
        listener.add(CompletedInitiationEvent());
      }
    });
  }
}
