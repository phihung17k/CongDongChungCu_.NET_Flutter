import 'package:congdongchungcu/models/apartment_model.dart';
import 'package:congdongchungcu/models/building_model.dart';
import 'package:equatable/equatable.dart';

class ResidentDialogState extends Equatable {
  final List<ApartmentModel> apartmentList;
  final List<BuildingModel> buildingList;
  final ApartmentModel selectedApartment;
  final BuildingModel selectedBuilding;

  ResidentDialogState(
      {this.apartmentList,
      this.buildingList,
      this.selectedApartment,
      this.selectedBuilding});

  ResidentDialogState copyWith(
      {List<ApartmentModel> apartmentList,
      List<BuildingModel> buildingList,
      ApartmentModel selectedApartment,
      BuildingModel selectedBuilding}) {
    return ResidentDialogState(
        apartmentList: apartmentList ?? this.apartmentList,
        buildingList: buildingList ?? this.buildingList,
        selectedApartment: selectedApartment ?? this.selectedApartment,
        selectedBuilding: selectedBuilding ?? this.selectedBuilding);
  }

  @override
  // TODO: implement props
  List<Object> get props =>
      [apartmentList, buildingList, selectedApartment, selectedBuilding];
}

class LoadingResidentDialogState extends ResidentDialogState {}
