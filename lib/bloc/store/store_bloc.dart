import 'package:congdongchungcu/base_bloc.dart';
import 'package:congdongchungcu/bloc/store/store_event.dart';
import 'package:congdongchungcu/bloc/store/store_state.dart';
import 'package:congdongchungcu/models/paging_result_model.dart';
import 'package:congdongchungcu/models/store_model.dart';
import 'package:congdongchungcu/models/store_model/get_store_codition.dart';
import 'package:congdongchungcu/models/store_model/get_store_model.dart';
import 'package:congdongchungcu/models/storedto_model.dart';
import 'package:congdongchungcu/repository/user_repository.dart';
import 'package:congdongchungcu/service/services.dart';
import 'package:get_it/get_it.dart';

class StoreBloc extends BaseBloc<StoreEvent, StoreState> {
  final IStoreService service;

  StoreBloc(this.service)
      : super(StoreState(
            currentListStore: [],
            getStoreModel: GetStoreModel(currPage: 1, NameOfStore: ""),
            storeOfCurrentResident: StoreDTO(name: ""))) {
    on((event, emit) async {
      //loadStoreDefault
      if (event is LoadStoreDefault) {
        //khỏi cần lấy apartmentId do service đã get sẵn
        StoreModel result = await service.getListStore(state.getStoreModel);

        //set state cho list
        if (result != null) {
          print("Có dữ liệu liststore r nha");
          //
          print(result.listStore[0].name);
          emit(state.copyWith(list: result.listStore, hasNext: result.hasNext));
        } else {
          print("LoadStoreDefault lỗi r nha");
        }
      }

      if (event is LoadStoreEvent) {
        //gọi api lấy list store
        //này na ná giống PagingResult

        StoreModel result = await service
            .getListStore(event.getStoreModel ?? state.getStoreModel);
        //print state của event currpage
        print("CurrPage: " + state.getStoreModel.currPage.toString());
        //

        //bắn ra ngoài render lại
        for (int i = 0; i < result.listStore.length; i++) {
          state.currentListStore.add(result.listStore[i]);
        }
        emit(
            //set state lại
            state.copyWith(
                list: state.currentListStore,
                getStoreModel: event.getStoreModel ?? state.getStoreModel,
                hasNext: result.hasNext));
      }

      //bắt sự kiện load more
      if (event is IncrementalStoreEvent) {
        //logic
        state.getStoreModel.currPage + 1;
        emit(state.copyWith(getStoreModel: state.getStoreModel));
      }

      if (event is RefreshStoreEvent) {
        //logic
        //cho list clear
        state.currentListStore.clear();
        //cho cur bằng 1
        state.getStoreModel.currPage = 1;
        //
        emit(state.copyWith(
            list: state.currentListStore,
            hasNext: state.hasNext,
            getStoreModel: state.getStoreModel));
      }

      //chỗ này mốt dùng get x để lấy store Id
      //Navigator Event
      if (event is NavigatorProductPageEvent) {
        print("NAVIGATOR chuyển từ trang store detail qua trang product page" +
            event.storeId.toString());
        //bloc listener để chuyển trang
        listener.add(NavigatorProductPageEvent(event.storeId));
        //
      }

      if (event is NavigatorToStoreDetail) {
        print("NAVIGATOR chuyển từ trang ListStore qua trang StoreDetail" +
            event.storeId.toString());
        //
        listener.add(NavigatorToStoreDetail(event.storeId));
      }

      //
      if (event is CheckStoreOfResidentEvent) {
        print("CheckStoreOfResidentEvent");

        //lấy resident id của current
        int residentId = GetIt.I.get<UserRepository>().selectedResident.id;

        StoreDTO dto = await service
            .getStoreByCondition(GetStoreCondition(residentId: residentId));

        if (dto != null) {
          //check xem STATUS của shop có active hay kh hay không
          if (dto.status) {
            print("TriggerProductBlocToLoadEvent listener add");
            //
            // listener.add(TriggerProductBlocToLoadEvent(dto.storeId));

            emit(state.copyWith(storeOfCurrentResident: dto));


          } else {
            //tạo ra event chuyển qua trang khác kích hoat shop
            listener.add(NavigatorToActiveShopEvent(dto));
          }
        }
        // else {
        //   //khi không có store
        //   listener.add(NavigatorToStoreInfo());
        // }
      }

      if (event is GetStoreEvent) {
        print("GetStoreEvent");
        StoreDTO dto = await service
            .getStoreByCondition(GetStoreCondition(storeId: event.storeId));

        if (dto != null) {
          print("GetStoreEvent thành công");
          emit(state.copyWith(storeOfCurrentResident: dto));
        } else {
          print("GetStoreEvent lỗi");
        }
      }

      if (event is NavigatorToStoreInfo) {
        //cho qua trang tạo store
        // rỗng có nghĩa là chưa có store
        if (state.storeOfCurrentResident.name == "") {
          listener.add(NavigatorToStoreInfo());
        } else {
          //
          print(
              "TẠO LISTENER VÀ CHUYỂN TRANG CHO TUI QUA TRANG STORE INFO ĐI MÀ");
          listener
              .add(PassStoreToStoreInfoPageEvent(state.storeOfCurrentResident));
        }
      }

      if (event is NavigatorToMyShopEvent) {
        print("NavigatorToMyShopEvent StoreBloc");

        //lấy apartment id của current
        int residentId = GetIt.I.get<UserRepository>().selectedResident.id;

        print("residentId: ${residentId}");

        StoreDTO dto = await service
            .getStoreByCondition(GetStoreCondition(residentId: residentId));
        // print("dtoaaaaaaaaaaa ${dto.storeId}");
        if (dto != null) {
          print("Store Id Bloc : " + dto.storeId.toString());
          listener.add(SendStoreIdToMyShopEvent(storeId: dto.storeId));
        } else {
          listener.add(SendStoreIdToMyShopEvent(storeId: 0));
        }
      }

      //management
      if (event is NavigateToProductPageManagementEvent) {
        //
        print('Navigate To ProductPageManagement');

        //
        listener.add(NavigateToProductPageManagementEvent(event.storeId));
      }
    });
  }
}
