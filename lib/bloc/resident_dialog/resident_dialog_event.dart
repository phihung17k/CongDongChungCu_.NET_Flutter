
import 'package:congdongchungcu/models/apartment_model.dart';
import 'package:congdongchungcu/models/building_model.dart';

class ResidentDialogEvent{}

class LoadingApartmentBuildingEvent extends ResidentDialogEvent {}

class GettingBuildingEvent extends ResidentDialogEvent{
  final ApartmentModel apartment;

  GettingBuildingEvent(this.apartment);
}

class SavingSelectedDataEvent extends ResidentDialogEvent {
  final BuildingModel buildingModel;

  SavingSelectedDataEvent(this.buildingModel);
}

class SendingSelectedDataBack extends ResidentDialogEvent{}

class SendingDataToWelcomePage {
  final ApartmentModel selectedApartment;
  final BuildingModel selectedBuilding;

  SendingDataToWelcomePage({this.selectedApartment, this.selectedBuilding});
}