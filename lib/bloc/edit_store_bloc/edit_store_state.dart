import 'package:congdongchungcu/models/storedto_model.dart';
import 'package:equatable/equatable.dart';

class EditStoreState extends Equatable
{

  final StoreDTO storeIsChoose;


  EditStoreState({this.storeIsChoose});

  EditStoreState copyWith(
      {StoreDTO storeIsChoose}) {
    return EditStoreState(storeIsChoose: storeIsChoose ?? this.storeIsChoose
    );
  }



  @override
  // TODO: implement props
  List<Object> get props => [storeIsChoose];

}