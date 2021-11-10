import 'package:congdongchungcu/models/resident_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/building_model.dart';
import '../../models/apartment_model.dart';
import '../../repository/user_repository.dart';
import 'package:get_it/get_it.dart';
import '../../service/interface/i_services.dart';
import '../../base_bloc.dart';
import 'profile_selection_event.dart';
import 'profile_selection_state.dart';

class ProfileSelectionBloc extends BaseBloc<ProfileSelectionEvent, ProfileSelectionState> {
  final IProfileSelectionService service;

  ProfileSelectionBloc(this.service) : super(ProfileSelectionState(residentList: const [])) {
    on((event, emit) async {
      if (event is GettingResidentInfoEvent) {
        emit(LoadingWelcomeState());
        UserRepository user = GetIt.I.get<UserRepository>();
        //get list resident model: id, isAdmin, apartmentId, buildingId
        user.residentList = await service.getResidents(user.id);
        if (user.residentList != null && user.residentList.isNotEmpty) {
          List<ResidentModel> list = [];
          //get apartment and building model in each resident
          for (var resident in user.residentList) {
            ApartmentModel apartment =
                await service.getApartment(resident.apartmentId);
            BuildingModel building =
                await service.getBuilding(resident.buildingId);
            if (apartment != null && building != null) {
              resident.apartmentModel = apartment;
              resident.buildingModel = building;
              list.add(resident);
            }
          }
          //save list resident model to user repository
          //user repository leak selectedResident
          user.residentList = list;
        }
        emit(state.copyWith(residentList: user.residentList));
      } else if (event is SelectingResidentEvent) {
        //save to share preferences
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setInt("selectedResidentId", event.resident.id);
        UserRepository user = GetIt.I.get<UserRepository>();
        //get auth Token
        String authToken = await service.getAuthToken(event.resident.id);
        event.resident.authToken = authToken;
        //save selected resident
        user.selectedResident = event.resident;
        listener.add(SelectingResidentEvent());
      } else if (event is ReloadingResidentEvent) {
        emit(LoadingWelcomeState());
        Map<String, int> mapId = {
          "buildingId": event.newBuilding.id,
          "apartmentId": event.newApartment.id
        };
        ResidentModel residentModel = await service.addResident(mapId);
        residentModel.apartmentModel = event.newApartment;
        residentModel.buildingModel = event.newBuilding;
        UserRepository user = GetIt.I.get<UserRepository>();
        user.residentList.add(residentModel);
        emit(state.copyWith(residentList: user.residentList));
      }
    });
  }
}
