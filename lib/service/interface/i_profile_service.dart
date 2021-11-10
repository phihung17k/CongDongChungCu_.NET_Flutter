
import 'package:congdongchungcu/models/store_model/get_store_codition.dart';
import 'package:congdongchungcu/models/storedto_model.dart';

abstract class IProfileService{
  Future<StoreDTO> getStoreByCondition(GetStoreCondition request);
}