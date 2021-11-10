import 'package:congdongchungcu/models/category_model/get_category_model.dart';
import 'package:congdongchungcu/models/store_model.dart';
import 'package:congdongchungcu/models/store_model/get_store_model.dart';
import 'package:congdongchungcu/models/storedto_model.dart';
import 'package:equatable/equatable.dart';

class StoreState extends Equatable
{
  final List<StoreDTO> currentListStore;
  final GetStoreModel getStoreModel;
  final bool hasNext;
  final StoreDTO storeOfCurrentResident;

  //
  const StoreState({this.currentListStore, this.getStoreModel ,this.hasNext, this.storeOfCurrentResident});

  //
  //set lại giá trị mới
  //thông qua hàm này mình có thể cho state mới vào
  StoreState copyWith({List<StoreDTO>list, GetStoreModel getStoreModel, bool hasNext, StoreDTO storeOfCurrentResident }) {
    return StoreState(
        currentListStore: list ?? this.currentListStore,
        getStoreModel: getStoreModel ?? this.getStoreModel,
        hasNext: hasNext ?? this.hasNext,
        storeOfCurrentResident: storeOfCurrentResident ?? this.storeOfCurrentResident
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [currentListStore, getStoreModel, hasNext, storeOfCurrentResident];
}