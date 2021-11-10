import 'package:congdongchungcu/bloc/poi/poi_event.dart';
import 'package:congdongchungcu/bloc/poi/poi_state.dart';
import 'package:congdongchungcu/models/paging_result_model.dart';
import 'package:congdongchungcu/models/poi/get_poi_model.dart';
import 'package:congdongchungcu/models/poi/poi_model.dart';
import 'package:congdongchungcu/models/poi/poi_type_model.dart';
import 'package:congdongchungcu/service/interface/i_poi_service.dart';

import '../../base_bloc.dart';
import '../../firebase_utils.dart';

class POIBloc extends BaseBloc<POIEvent, POIState> {
  final IPoiService service;

  POIBloc(this.service)
      : super(POIState(
          currentListPoi: [],
          getPoiModel: GetPOIModel(currPage: 1),
          hasNext: false,
          listPoiType: [],
        )) {
    on((event, emit) async {
      if (event is GetAllPOIEvent) {
        print("current page "+state.getPoiModel.currPage.toString());
        print("list current "+state.currentListPoi.length.toString());
        print("has next"+state.hasNext.toString());
        PagingResult<POIModel> pagingResult =
            await service.getPoiByCondition(state.getPoiModel);
            if(pagingResult != null){
        List<POIModel> items = pagingResult.items;
        if (state.currentListPoi.isNotEmpty) {
          for (int i = 0; i < items.length; i++) {
            POIModel item = items[i];
            String imageUrl = await FirebaseUtils.getImageUrl("poi", item.id);
            if (imageUrl != null) {
              item.imagePath = imageUrl;
            }
            state.currentListPoi.add(item);
          }
          emit(state.copyWith(
              currentListPoi: state.currentListPoi,
              hasNext: pagingResult.hasNext,
              getPoiModel: state.getPoiModel));
        } else {
          for (int i = 0; i < items.length; i++) {
            POIModel item = items[i];
            String imageUrl = await FirebaseUtils.getImageUrl("poi", item.id);
            if (imageUrl != null) {
              item.imagePath = imageUrl;
            }
          }
          emit(state.copyWith(
              currentListPoi: items,
              hasNext: pagingResult.hasNext,
              getPoiModel: state.getPoiModel));
        }
            }
            else{
               emit(state.copyWith(
              currentListPoi: [],
              hasNext: false,
              getPoiModel: state.getPoiModel));
            }
      }
      if (event is NavigatorEditPOIEvent) {
        listener.add(event);
      }

      if (event is SelectPOITypeEvent) {
        List<POITypeModel> listPOIType = await service.getPoiType();
        POITypeModel poiTypeAll = POITypeModel(id: 0, name: "Tất cả");
        List<POITypeModel> listPOITypeNew = [];
        listPOITypeNew.add(poiTypeAll);
        listPOITypeNew.addAll(listPOIType);
        emit(state.copyWith(listPoiType: listPOITypeNew));
      }

      if (event is SelectDropdownNewValue) {
        // print("SelectDropdownNewValue");
        // PagingResult<POIModel> pagingResult =
        //     await service.getPoiByCondition(event.getPOIModel);
        // List<POIModel> items = [];
        // if (pagingResult != null) {
        //   items = pagingResult.items;
        //   for (int i = 0; i < items.length; i++) {
        //     POIModel item = items[i];
        //     String imageUrl = await FirebaseUtils.getImageUrl("poi", item.id);
        //     if (imageUrl != null) {
        //       item.imagePath = imageUrl;
        //     }
        //   }
        // }
        // print("items");
        // print(items);
        // emit(state.copyWith(currentListPoi: items));
         state.getPoiModel.currPage = 1;
        state.getPoiModel.poiTypeId = event.getPOIModel.poiTypeId;
        emit(state.copyWith(
            currentListPoi: <POIModel>[],
            getPoiModel: state.getPoiModel,
            hasNext: false,
             dropdownValue: event.dropdownNewValue));
      }

      if (event is InputSearchValue) {
        // print("Input Search Value");
        // PagingResult<POIModel> pagingResult =
        //     await service.getPoiByCondition(event.getPOIModel);
        // print(pagingResult);
        // List<POIModel> items = [];
        // if (pagingResult != null) {
        //   items = pagingResult.items;
        //   for (int i = 0; i < items.length; i++) {
        //     POIModel item = items[i];
        //     String imageUrl = await FirebaseUtils.getImageUrl("poi", item.id);
        //     if (imageUrl != null) {
        //       item.imagePath = imageUrl;
        //     }
        //   }
        // }
        // print("items");
        // print(items);
        // emit(state.copyWith(currentListPoi: items));
        state.getPoiModel.currPage = 1;
        state.getPoiModel.name = event.getPOIModel.name;
        emit(state.copyWith(
            currentListPoi: <POIModel>[],
            getPoiModel: state.getPoiModel,
            hasNext: false));
      }

      if (event is IncreaseNewsCurrPage) {
        state.getPoiModel.currPage++;
        emit(state.copyWith(getPoiModel: state.getPoiModel));
      }

      if (event is RefreshNews) {
        state.getPoiModel.currPage = 1;
        emit(state.copyWith(
            currentListPoi: <POIModel>[],
            getPoiModel: state.getPoiModel,
            hasNext: false));
      }

      if(event is NavigatorToGoogleMapEvent){
        listener.add(event);
      }
    });
  }
}
