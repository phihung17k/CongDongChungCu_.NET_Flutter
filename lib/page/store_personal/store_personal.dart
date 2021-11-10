import 'package:congdongchungcu/bloc/productBloc/product_bloc.dart';
import 'package:congdongchungcu/bloc/productBloc/product_event.dart';
import 'package:congdongchungcu/bloc/productBloc/product_state.dart';

import 'package:congdongchungcu/bloc/store/store_bloc.dart';
import 'package:congdongchungcu/bloc/store/store_event.dart';
import 'package:congdongchungcu/bloc/store/store_state.dart';
import 'package:congdongchungcu/category_private/category_private_bloc.dart';
import 'package:congdongchungcu/category_private/category_private_event.dart';
import 'package:congdongchungcu/category_private/category_private_state.dart';
import 'package:congdongchungcu/models/category_model/get_category_model.dart';
import 'package:congdongchungcu/models/enum.dart';
import 'package:congdongchungcu/models/product_model/get_product_model.dart';
import 'package:congdongchungcu/models/product_model/product_agrument.dart';
import 'package:congdongchungcu/page/category/widgets/list_view_category_private.dart';

import 'package:congdongchungcu/page/store/widgets/icon_btn_with_counter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadmore/loadmore.dart';
import '../../app_colors.dart';
import 'package:flutter/material.dart';
import '../../dimens.dart';
import '../../router.dart';
import '../store/Product.dart';
import '../store/widgets/list_view_product_store.dart';
import '../store/widgets/popular_product.dart';

class StorePersonal extends StatefulWidget {
  final ProductBloc productBloc;

  //sài ké store bloc để check
  final StoreBloc storeBloc;

  //
  final CategoryPrivateBloc categoryPrivateBloc;

  StorePersonal({this.productBloc, this.storeBloc, this.categoryPrivateBloc});

  @override
  _StorePersonalState createState() => _StorePersonalState();
}

class _StorePersonalState extends State<StorePersonal> {
  ProductBloc get _productBloc => widget.productBloc;

  StoreBloc get _storeBloc => widget.storeBloc;

  CategoryPrivateBloc get _categoryPrivateBloc => widget.categoryPrivateBloc;

  int storeId;

  int storeName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //lắng nghe event
    _storeBloc.listenerStream.listen((event) async {

      // //Để CreateStore chắc chắn chỗ này kh chạy
      // if (event is NavigatorToStoreInfo) {
      //   print("qua trang edit store info");
      //   Navigator.of(context).pushNamed(Routes.editStore);
      // }

      if (event is PassStoreToStoreInfoPageEvent) {
        //
        print("gửi store qua cho trang store info");
        //
        storeId = await Navigator.of(context)
            .pushNamed(Routes.editStore, arguments: event.st) as int;

        if (storeId != null && storeId > 0) {
          print(
              "Nhận Giá Trị Store ID từ trang Edit StoreINFO gửi qua bằng pop");
          _storeBloc.add(CheckStoreOfResidentEvent());

          _productBloc.add(LoadProductByStorePageEvent(
              request:
                  GetProductModel(StoreId: storeId))); // chưa truyền status
          //
          _categoryPrivateBloc.add(LoadCategoryPrivateEvent(
              getCategoryModel: GetCategoryModel(storeId: storeId)));

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Cập nhật thông tin Cửa Hàng thành công"),
          ));
        }
      }


      if (event is NavigatorToActiveShopEvent) {
        //chuyển qua trang active
        print("gửi store qua cho trang storeActivePAGE");
        //
        Navigator.of(context)
            .pushReplacementNamed(Routes.storeActive, arguments: event.dto);
      }
    });

    // _storeBloc.listenerStream.listen((event) {
    //   //từ profilepage đi qua my shop sẽ load product
    //   if (event is TriggerProductBlocToLoadEvent) {
    //     //
    //     print("TriggerProductBlocToLoadEvent");
    //     //
    //     _productBloc.add(LoadProductByStorePageEvent(
    //         request: GetProductModel(StoreId: event.storeId)));
    //   }
    // });

    //Gửi product Model qua cho EditProduct để update
    _productBloc.listenerStream.listen((event) async {
      if (event is SelectingProductEvent) {
        //
        print("Chuyển dữ liệu Product is choose qua cho trang edit product");
        //
        storeId = await Navigator.of(context).pushNamed(Routes.addNewProduct,
            arguments: event.productIsChoose) as int;

        if (storeId > 0) {
          print("Nhận Giá Trị Store ID từ trang Edit Product gửi qua bằng pop");

          _productBloc.add(LoadProductByStorePageEvent(
              request:
                  GetProductModel(StoreId: storeId))); // chưa truyền status

          _categoryPrivateBloc.add(LoadCategoryPrivateEvent(
              getCategoryModel: GetCategoryModel(storeId: storeId)));

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Cập nhật sản phẩm thành công"),
          ));
        }
      }

      //gửi store id qua cho trang edit Product để Create Product
      if (event is PassStoreIdToAddNewProductEvent) {
        //
        print("gửi store id qua cho trang edit product");
        //
        storeId = await Navigator.of(context)
            .pushNamed(Routes.addNewProduct, arguments: event.storeId) as int;

        if (storeId > 0) {
          print("Nhận Giá Trị Store ID từ trang Edit Product gửi qua bằng pop");

          _productBloc.add(LoadProductByStorePageEvent(
              request:
                  GetProductModel(StoreId: storeId))); // chưa truyền status

          _categoryPrivateBloc.add(LoadCategoryPrivateEvent(
              getCategoryModel: GetCategoryModel(storeId: storeId)));

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Tạo sản phẩm phẩm thành công"),
          ));
        }
      }
    });

    //CATEGORY PRIVATE trigger khi user chọn 1 category t
    _categoryPrivateBloc.listenerStream.listen((event) {
      if (event is SelectCategoryPrivateEvent) {
        //
        _productBloc.add(LoadProductByStorePageEvent(
            request: GetProductModel(
                categoryId: event.categoryModelIsChoose.id,
                StoreId: storeId,
                currPage: 1)));
      }
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    RouteSettings settings = ModalRoute.of(context).settings;
    if (settings.arguments != null) {
      // storeId = settings.arguments as int;
      storeId = settings.arguments as int;


      print("StoreId nhận từ những trang profile và store info: " +
          storeId.toString());
      //check này để emit ra store
      _storeBloc.add(CheckStoreOfResidentEvent());

        //load list sản phẩm của store đấy
        _productBloc.add(LoadProductByStorePageEvent(
            request: GetProductModel(StoreId: storeId))); // chưa truyền status

        _categoryPrivateBloc.add(LoadCategoryPrivateEvent(
            getCategoryModel: GetCategoryModel(storeId: storeId)));

    }
  }

  @override
  Widget build(BuildContext context) {
    return
        // //Trang này dành cho có store
        Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              title: BlocBuilder<StoreBloc, StoreState>(
                bloc: _storeBloc,
                builder: (context, state) {
                  return state.storeOfCurrentResident.name == ""
                      ? Text('storeName kh có')
                      : Text(state.storeOfCurrentResident.name,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: Dimens.size23));
                },
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    // print("STORE ID MY SHOP NAVIGATE QUA STORE INFO: " +
                    //     state.storeOfCurrentResident.storeId.toString());
                    _storeBloc.add(NavigatorToStoreInfo());
                  },
                  child: Icon(Icons.edit,
                      color: Colors.black, size: Dimens.size25),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: Dimens.size16),
                  child: IconBtnWithCounter(
                    svgSrc: "assets/icons/Bell.svg",
                    numOfitem: 3,
                    onTap: () {
                      // Navigator.of(context).pushNamed(Routes.get_notification);
                    },
                  ),
                ),
              ],
              backgroundColor: AppColors.primaryColor, //backgroundCategoryCard
            ),
            body: BlocProvider.value(
              value: _productBloc,
              child: Container(
                color: Colors.grey[100],
                child: Column(children: [
                  SizedBox(height: 3),

                  SizedBox(height: 5),

                  Container(
                    padding: EdgeInsets.all(Dimens.size5),
                    color: Colors.white,
                    child: Row(children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimens.size20, vertical: Dimens.size10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'QUẢN LÝ SẢN PHẨM CỦA BẠN',
                            style: TextStyle(
                                fontSize: Dimens.size18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ]),
                  ),
                  //category
                  //gọi Widget category
                  BlocProvider.value(
                    value: _categoryPrivateBloc,
                    child:
                        BlocBuilder<CategoryPrivateBloc, CategoryPrivateState>(
                      bloc: _categoryPrivateBloc,
                      builder: (context, state) {
                        return state.listCategory.isEmpty
                            ? Text('no list cate')
                            : ListViewCategoryPrivate(
                                listCategory: state.listCategory);
                      },
                    ),
                  ),

                  Expanded(child: ListViewProductStore()),
                ]),
              ),
            ),
            floatingActionButton: BlocBuilder<StoreBloc, StoreState>(
              bloc: _storeBloc,
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: FloatingActionButton(
                    backgroundColor: AppColors.primaryColor,
                    onPressed: () {
                      print("Store id floatingActionButton" +
                          state.storeOfCurrentResident.storeId.toString());
                      _productBloc.add(PassStoreIdToAddNewProductEvent(
                          storeId: ProductAgrument(
                              storeId: state.storeOfCurrentResident.storeId)));
                    },
                    tooltip: 'Increment',
                    child: Icon(Icons.add, size: Dimens.size35),
                  ),
                );
              },
            ));
  }
}
