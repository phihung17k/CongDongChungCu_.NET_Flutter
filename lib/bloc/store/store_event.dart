import 'package:congdongchungcu/models/store_model/get_store_model.dart';
import 'package:congdongchungcu/models/storedto_model.dart';

class StoreEvent{}

//load currpage = 1
class LoadStoreDefault extends StoreEvent{}


class LoadStoreEvent extends StoreEvent{
    //
    GetStoreModel getStoreModel;
    //
    LoadStoreEvent({this.getStoreModel});
}

class GetStoreEvent extends StoreEvent
{
    final int storeId;

    GetStoreEvent(this.storeId);
}

// cập nhật lại cái state get model
class IncrementalStoreEvent extends StoreEvent{}

class RefreshStoreEvent extends StoreEvent{}

//Navigate
class NavigatorProductPageEvent extends StoreEvent{
    final int storeId;

    NavigatorProductPageEvent(this.storeId);
}
//create store
class NavigatorToStoreInfo extends StoreEvent{}
//
class NavigatorToMyShopEvent extends StoreEvent {}
//
class NavigatorToStoreDetail extends StoreEvent{
    final int storeId;

    NavigatorToStoreDetail(this.storeId);
}

//MANAGEMENT
class NavigateToProductPageManagementEvent extends StoreEvent{
    final int storeId;

    NavigateToProductPageManagementEvent(this.storeId);
}

//Trigger
//nếu có shop thì gửi store id qua cho productBloc
class TriggerProductBlocToLoadEvent extends StoreEvent
{
    final int storeId;

    TriggerProductBlocToLoadEvent(this.storeId);
}




//qua trang kích hoạt store
class NavigatorToActiveShopEvent extends StoreEvent
{
    final StoreDTO dto;
    NavigatorToActiveShopEvent(this.dto);
}

//check
class CheckStoreOfResidentEvent extends StoreEvent{
}

// PASS DATA
class SendStoreIdToMyShopEvent extends StoreEvent
{
    final int storeId;
    SendStoreIdToMyShopEvent({this.storeId});
}

class PassStoreToStoreInfoPageEvent extends StoreEvent
{
    final StoreDTO st;
    PassStoreToStoreInfoPageEvent(this.st);
}

class ShowingStoreEvent extends StoreEvent{
    final StoreDTO dto;

    ShowingStoreEvent({this.dto});
}