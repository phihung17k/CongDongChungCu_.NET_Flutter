import 'package:congdongchungcu/models/enum.dart';
import 'package:congdongchungcu/models/news/get_news_model.dart';
import 'package:congdongchungcu/models/paging_result_model.dart';
import 'package:congdongchungcu/models/product_model/get_product_model.dart';
import 'package:congdongchungcu/models/product_model/product_agrument.dart';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:congdongchungcu/models/store_model.dart';

import '../../firebase_utils.dart';
import '/bloc/productBloc/product_state.dart';
import '/models/product_model/product_model.dart';
import '/service/services.dart';
import '../../base_bloc.dart';
import 'product_event.dart';

class ProductBloc extends BaseBloc<ProductEvent, ProductState> {
  final IProductService service;

  //đưa init state vào cho bloc
  ProductBloc({this.service})
      : super(ProductState(
          currentlistProduct: [],
          getProductModel: GetProductModel(
            currPage: 1,
          ),
          hasNext: false,
          productIsChoose: ProductModel(name: ""),
          curpage: 1,
          isChanged: false,
        )) {
    on((event, emit) async {
      if (event is LoadingEvent) {
        // check cái state currpage có lên + 1 sau khi chạy qua Incremental event kh
        print("Loading Event Currpage: " +
            state.getProductModel.currPage.toString());

        //này cho no biết load more theo category nào
        // điều này cho thấy nó đang giữ state
        state.getProductModel.categoryId = state.categoryId;
        print(state.getProductModel.categoryId);
        state.getProductModel.StoreId = state.storeId;
        print(state.getProductModel.StoreId);
        state.getProductModel.currPage = state.curpage;
        print(state.getProductModel.currPage);
        state.getProductModel.status = state.status;
        print(state.getProductModel.status);

        PagingResult<ProductModel> Result =
            await service.getProductByGeneral(state.getProductModel);

        if (Result.items.isNotEmpty) {
          //bắn ra ngoài render lại
          for (int i = 0; i < Result.items.length; i++) {
            //gọi lại list state để thêm load more
            String imageUrl = await FirebaseUtils.getImageUrl(
                "product_image", Result.items[i].id);
            Result.items[i].imagePath = imageUrl;
            state.currentlistProduct.add(Result.items[i]);
            // here
          }

          List<ProductModel> list = state.currentlistProduct;

          emit(state.copyWith(
              //new data
              list: list,
              getProductModel: state.getProductModel,
              //này để cho load more check điều kiện
              hasNext: Result.hasNext,
              isChanged: !state.isChanged),
          );
        }
      }

      if (event is LoadProductByStorePageEvent) {
        //print("Event :" + event.request.categoryId.toString());
        //print("Status :" + event.request.status.toString());
        print("ToString -------------- ${event.request.toString()}");
        PagingResult<ProductModel> result = await service
            .getProductByGeneral(event.request ?? state.getProductModel);
        // ở đây đây đưa hản cái list được trả ra từ get data from api
        //đầu ra dữ liệu
        if (result != null) {
          for (int i = 0; i < result.items.length; i++) {
            // String fullPath = await FirebaseStorage.instance
            //     .ref("product_image/${result.items[i].id}")
            //     .fullPath;

            String imageUrl = await FirebaseUtils.getImageUrl(
                "product_image", result.items[i].id);
            print("imageUrl ${imageUrl}");
            result.items[i].imagePath = imageUrl;
          }

          emit(state.copyWith(
            list: result.items,
            hasNext: result.hasNext,
            categoryId: event.request.categoryId,
            storeId: event.request.StoreId,
            curpage: event.request.currPage,
            status: event.request.status,
            isChanged: !state.isChanged,
          ));
        } else {
          emit(state.copyWith(list: <ProductModel>[]));
        }
      }

      //event load product into general Page
      if (event is LoadProductGeneralPageEvent) {
        print("LoadProductGeneralPageEvent");
        //tạo get model
        GetProductModel requestLoad =
            GetProductModel(status: Status.Approved, pageSize: 30);

        PagingResult<ProductModel> Result =
            await service.getProductByGeneral(requestLoad);

        // get image
        for (int i = 0; i < Result.items.length; i++) {
          // String fullPath = await FirebaseStorage.instance
          //     .ref("product_image/${result.items[i].id}")
          //     .fullPath;

          String imageUrl = await FirebaseUtils.getImageUrl(
              "product_image", Result.items[i].id);
          Result.items[i].imagePath = imageUrl;
        }

        //
        emit(state.copyWith(list: Result.items));
      }

      if (event is LoadProductGeneralPageHasCategoryIdEvent) {
        print("LoadProductGeneralPageHasCategoryIdEvent");
        //tạo get model
        GetProductModel requestLoad = GetProductModel(
            status: event.model.status,
            categoryId: event.model.categoryId,
            pageSize: 30);

        PagingResult<ProductModel> Result =
            await service.getProductByGeneral(requestLoad);

        // get image
        for (int i = 0; i < Result.items.length; i++) {
          // String fullPath = await FirebaseStorage.instance
          //     .ref("product_image/${result.items[i].id}")
          //     .fullPath;

          String imageUrl = await FirebaseUtils.getImageUrl(
              "product_image", Result.items[i].id);
          Result.items[i].imagePath = imageUrl;
        }
        //
        emit(state.copyWith(list: Result.items, getProductModel: requestLoad));
      }

      //event load more
      if (event is IncrementalProductEvent) {
        //
        print("IncrementalProductEvent ở đây nè");
        //logic

        emit(state.copyWith(curpage: state.curpage + 1));
      }
      //event refresh
      if (event is RefreshProductEvent) {
        //logic
        state.currentlistProduct.clear();

        print("chạy refresh");
        print("đây là giá trị store id: " + state.storeId.toString());

        emit(state.copyWith(
            list: <ProductModel>[], curpage: 1, hasNext: state.hasNext));
      }

      //selecting product event
      //navigate sang trang
      if (event is SelectingProductEvent) {
        print("SelectingProductEvent");
        //
        listener
            .add(SelectingProductEvent(productIsChoose: event.productIsChoose));
        //set trạng thái
        // emit(
        //   state.copyWith(productIsChoose: event.productIsChoose)
        // );
      }

      //pass data to category lúc create
      if (event is PassStoreIdToAddNewProductEvent) {
        //cho data cứng của 1 store
        listener.add(PassStoreIdToAddNewProductEvent(
            storeId: ProductAgrument(storeId: event.storeId.storeId)));
        //
      }

      //chuyển sang trang product detail page
      if (event is NavigatorToDetailPage) {
        //
        listener.add(NavigatorToDetailPage(event.model));
      }

      //
      if (event is RecieveDataEvent) {
        print(event.dto.name);

        emit(state.copyWith(productIsChoose: event.dto));
      }

      if (event is NavigatorToStoreDetailEvent) {
        listener.add(NavigatorToStoreDetailEvent(event.storeId));
      }

      if (event is SearchTopProductEvent) {
        //MODEL
        //List<ProductModel> newListStore = [];
        String name = event.request.NameOfProduct;
        state.getProductModel.NameOfProduct = name;
        print("Name của getProduct request gửi vào: " +
            state.getProductModel.NameOfProduct);
        print("storeId của storeId State: " + state.storeId.toString());
        print("Category của Category State: " + state.categoryId.toString());
        print("status của status request gửi vào: " +
            event.request.status.toString());

        print("SearchTopProductEvent");
        //

        GetProductModel requestLoad = GetProductModel(
            status: event.request.status,
            categoryId: state.categoryId,
            NameOfProduct: event.request.NameOfProduct,
            pageSize: 30);

        PagingResult<ProductModel> Result =
            await service.getProductByGeneral(requestLoad);

        // get image
        for (int i = 0; i < Result.items.length; i++) {
          String imageUrl = await FirebaseUtils.getImageUrl(
              "product_image", Result.items[i].id);
          Result.items[i].imagePath = imageUrl;
        }
        //
        emit(state.copyWith(list: Result.items, getProductModel: requestLoad));

        // //lấy state list hiện tại so sánh thỏa thì sẽ emit ra list mới và show lên
        // for (int i = 0; i < state.currentlistProduct.length; i++) {
        //   if (state.currentlistProduct[i].name.contains(name)) {
        //     newListStore.add(state.currentlistProduct[i]);
        //   }
        // }
        // print("số lượng sản phẩm thỏa yêu cầu search");
        // emit(state.copyWith(list: newListStore));

      }
    });
  }
}
