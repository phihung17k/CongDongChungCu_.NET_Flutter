import 'package:congdongchungcu/models/storedto_model.dart';

class EditStoreEvent {}

//nhận data
class RecieveStoreDTO extends EditStoreEvent {
  final StoreDTO storeDto;

  RecieveStoreDTO({this.storeDto});
}

//add new store
class AddNewStoreEvent extends EditStoreEvent {
  final StoreDTO model;

  AddNewStoreEvent(this.model);
}

//update store
class UpdateStoreEvent extends EditStoreEvent {
  final StoreDTO model;

  UpdateStoreEvent(this.model);
}

//delete store
class DeleteStoreEvent extends EditStoreEvent {
  final StoreDTO model;

  DeleteStoreEvent(this.model);
}

//navigate
class NavigateToStorePageEvent extends EditStoreEvent {
  int storeId;

  NavigateToStorePageEvent({this.storeId});
}

class PassDataToStorePersonalEvent extends EditStoreEvent {
  final int storeId;

  PassDataToStorePersonalEvent(this.storeId);
}
