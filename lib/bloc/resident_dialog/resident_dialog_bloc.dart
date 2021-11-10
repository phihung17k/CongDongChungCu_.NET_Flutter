import 'package:congdongchungcu/base_bloc.dart';
import 'package:congdongchungcu/bloc/resident_dialog/resident_dialog_event.dart';
import 'package:congdongchungcu/bloc/resident_dialog/resident_dialog_state.dart';
import 'package:congdongchungcu/models/apartment_model.dart';
import 'package:congdongchungcu/models/building_model.dart';
import 'package:congdongchungcu/service/interface/i_resident_dialog_service.dart';

class ResidentDialogBloc
    extends BaseBloc<ResidentDialogEvent, ResidentDialogState> {
  final IResidentDialogService service;

  ResidentDialogBloc(this.service) : super(ResidentDialogState()) {
    on((event, emit) async{
      if (event is LoadingApartmentBuildingEvent) {
        List<ApartmentModel> apartmentList = await service.getAllApartment();
        List<BuildingModel> buildingList = await service.getAllBuilding();
        if (apartmentList.isNotEmpty && buildingList.isNotEmpty) {
          emit(state.copyWith(
              apartmentList: apartmentList, buildingList: buildingList));
        }
      } else if (event is GettingBuildingEvent){
        List<BuildingModel> buildingList = [];
        for(BuildingModel building in state.buildingList){
          if(building.apartmentId == event.apartment.id){
            buildingList.add(building);
          }
        }
        emit(state.copyWith(
          buildingList: buildingList,
          selectedApartment: event.apartment,
          selectedBuilding: null,
        ));
      } else if(event is SavingSelectedDataEvent){
        emit(state.copyWith(
          selectedBuilding: event.buildingModel
        ));
      } else if(event is SendingSelectedDataBack){
        listener.add(SendingDataToWelcomePage(
            selectedApartment: state.selectedApartment,
            selectedBuilding: state.selectedBuilding
        ));
      }
    });
  }
}
