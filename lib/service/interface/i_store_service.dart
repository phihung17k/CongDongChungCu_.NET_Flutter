import 'package:congdongchungcu/models/store_model.dart';
import 'package:congdongchungcu/models/store_model/get_store_codition.dart';
import 'package:congdongchungcu/models/store_model/get_store_model.dart';
import 'package:congdongchungcu/models/storedto_model.dart';

abstract class IStoreService{
  Future<StoreModel> getListStore(GetStoreModel request);

  Future<StoreDTO> getStoreByCondition(GetStoreCondition request);

  //add store
  Future<StoreDTO> addStore(StoreDTO model);

  //update store
  Future<bool> updateStore(StoreDTO model);

  //delete store
  Future<bool> deleteStore(StoreDTO model);
}