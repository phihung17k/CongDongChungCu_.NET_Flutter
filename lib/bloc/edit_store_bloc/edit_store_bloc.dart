import 'package:congdongchungcu/models/storedto_model.dart';
import 'package:congdongchungcu/service/interface/i_store_service.dart';

import '../../base_bloc.dart';
import 'edit_store_event.dart';
import 'edit_store_state.dart';

class EditStoreBloc extends BaseBloc<EditStoreEvent, EditStoreState> {
  final IStoreService service;

  //đưa init state vào cho bloc
  EditStoreBloc({this.service})
      : super(EditStoreState(storeIsChoose: StoreDTO(name: ""))) {
    on((event, emit) async {
      if (event is RecieveStoreDTO) {
        //set state
        print("Nhận data từ storePersonal");
        //
        emit(state.copyWith(storeIsChoose: event.storeDto));
      }

      if (event is AddNewStoreEvent) {
        //
        print("Tạo Store ");
        //
        StoreDTO result = await service.addStore(event.model);
        //
        if (result != null) {
          print("Tạo Thành Công Store");
          //tạo event chuyển lại trang store
          listener.add(NavigateToStorePageEvent(storeId: result.storeId));
          // emit(
          //   state.copyWith()
          // );
        } else {
          print("Tạo Không Thành Công");
        }
      }

      if (event is UpdateStoreEvent) {
        //
        print("update Store ");
        //
        bool result = await service.updateStore(event.model);
        //

        if (result) {
          print("Update Thành Công Store");
          //
          listener
              .add(PassDataToStorePersonalEvent(state.storeIsChoose.storeId));
        } else {
          print("Update Không Thành Công");
        }
      }

      if (event is DeleteStoreEvent) {
        //
        print("delete Store ");
        //
        bool result = await service.deleteStore(event.model);
        //

        if (result) {
          print("delete Thành Công Store");
          //
          listener
              .add(PassDataToStorePersonalEvent(state.storeIsChoose.storeId));
        } else {
          print("delete Không Thành Công");
        }
      }
    });
  }
}
