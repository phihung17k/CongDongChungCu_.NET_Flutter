import 'package:congdongchungcu/base_bloc.dart';
import 'package:congdongchungcu/bloc/store_main/store_main_event.dart';
import 'package:congdongchungcu/bloc/store_main/store_main_state.dart';
import 'package:congdongchungcu/models/category_model/category_model.dart';
import 'package:congdongchungcu/models/category_model/category_result.dart';
import 'package:congdongchungcu/models/category_model/get_category_model.dart';
import 'package:congdongchungcu/models/enum.dart';
import 'package:congdongchungcu/models/paging_result_model.dart';
import 'package:congdongchungcu/models/product_model/get_product_model.dart';
import 'package:congdongchungcu/models/product_model/product_model.dart';
import 'package:congdongchungcu/service/interface/i_services.dart';

import '../../firebase_utils.dart';

class StoreMainBloc extends BaseBloc<StoreMainEvent, StoreMainState> {
  final IStoreMainService service;

  StoreMainBloc(this.service)
      : super( StoreMainState(
          listCategory: [],
          listProduct: [],
    getProductModel:  GetProductModel(NameOfProduct: ""),
    isCategoryChoose:  CategoryModel(id: 0),
        )) {
    on((event, emit) async {
      if (event is LoadCategoryDefaultEvent) {
        CategoryResult result =
            await service.getCategoriesOfStore(GetCategoryModel(storeId: null));
        if (result != null) {
          print("LoadCategoryDefault thành công");
          emit(state.copyWith(listCategory: result.listCate));
        } else {
          print("LoadCategoryDefault lỗi");
        }
      }
      if (event is LoadProductGeneralPageGeneralEvent) {
        GetProductModel requestLoad =
            GetProductModel(status: Status.Approved, pageSize: 30);
        PagingResult<ProductModel> result =
            await service.getProductByGeneral(requestLoad);
        // get image
        for (int i = 0; i < result.items.length; i++) {
          String imageUrl = await FirebaseUtils.getImageUrl(
              "product_image", result.items[i].id);
          result.items[i].imagePath = imageUrl;
        }
        //
        emit(state.copyWith(listProduct: result.items));
      }
      if (event is SelectCategoryEvent) {
        print("giá trị của category được chọn: " +
            event.categoryModelIsChoose.name);
        GetProductModel requestLoad = GetProductModel(
            status: Status.Approved,
            categoryId: event.categoryModelIsChoose.id,
            pageSize: 30);
        PagingResult<ProductModel> result =
            await service.getProductByGeneral(requestLoad);
        // get image
        for (int i = 0; i < result.items.length; i++) {
          String imageUrl = await FirebaseUtils.getImageUrl(
              "product_image", result.items[i].id);
          result.items[i].imagePath = imageUrl;
        }
        emit(state.copyWith(
            isCategoryChoose: event.categoryModelIsChoose,
            listProduct: result.items,
            getProductModel: requestLoad));
      }
      if (event is SearchTopProductGeneralEvent) {
        //MODEL
        //List<ProductModel> newListStore = [];
        // String name = event.request.NameOfProduct;
        // state.getProductModel.NameOfProduct = name;
        // print("Name của getProduct request gửi vào: " +
        //     state.getProductModel.NameOfProduct);
        // // print("storeId của storeId State: "+ state.storeId.toString());
        // print("Category của Category State: " +
        //     state.isCategoryChoose.toString());
        // print("status của status request gửi vào: " +
        //     event.request.status.toString());
        print("SearchTopProductEvent");
        //
        GetProductModel requestLoad = GetProductModel(
            status: event.request.status,
            categoryId: state.isCategoryChoose.id,
            NameOfProduct: event.request.NameOfProduct,
            pageSize: 30);

        PagingResult<ProductModel> result =
            await service.getProductByGeneral(requestLoad);

        if (result != null) {
          // get image
          for (int i = 0; i < result.items.length; i++) {
            String imageUrl = await FirebaseUtils.getImageUrl(
                "product_image", result.items[i].id);
            result.items[i].imagePath = imageUrl;
          }
          //
          emit(state.copyWith(
              listProduct: result.items, getProductModel: requestLoad));
        } else {
          emit(state.copyWith(
              listProduct: <ProductModel>[], getProductModel: requestLoad));
        }
      }
    });
  }
}
