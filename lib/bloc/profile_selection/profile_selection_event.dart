import 'package:congdongchungcu/models/apartment_model.dart';
import 'package:congdongchungcu/models/building_model.dart';

import '../../models/resident_model.dart';

class ProfileSelectionEvent {}

class GettingResidentInfoEvent extends ProfileSelectionEvent {}

class SelectingResidentEvent extends ProfileSelectionEvent {
  final ResidentModel resident;

  SelectingResidentEvent({this.resident});
}

class ReloadingResidentEvent extends ProfileSelectionEvent{
  final ApartmentModel newApartment;
  final BuildingModel newBuilding;

  ReloadingResidentEvent({this.newApartment, this.newBuilding});
}
