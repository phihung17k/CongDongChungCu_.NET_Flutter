

import 'package:congdongchungcu/bloc/productBloc/product_state.dart';
import 'package:congdongchungcu/category_private/category_private_bloc.dart';
import 'package:congdongchungcu/category_private/category_private_event.dart';
import 'package:congdongchungcu/category_private/category_private_state.dart';

import 'package:congdongchungcu/models/category_model/get_category_model.dart';
import 'package:congdongchungcu/models/enum.dart';
import 'package:congdongchungcu/models/product_model/get_product_model.dart';

import 'package:congdongchungcu/page/category/widgets/list_view_category_private.dart';
import 'package:congdongchungcu/page/product/widgets/listview_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../app_colors.dart';

import '../../dimens.dart';
import '../../router.dart';
import '/bloc/productBloc/product_event.dart';
import '/bloc/productBloc/product_bloc.dart';

class ProductPage extends StatefulWidget {
  final ProductBloc Productbloc;

  //final CategoryBloc Categorybloc;

  final CategoryPrivateBloc categoryPrivateBloc;

  ProductPage({this.Productbloc, this.categoryPrivateBloc});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  ProductBloc get Productbloc => widget.Productbloc;

  // xài ké cái categorybloc
  //CategoryBloc get Categorybloc => widget.Categorybloc;

  //
  CategoryPrivateBloc get _categoryPrivateBloc => widget.categoryPrivateBloc;

  int storeIdEdit;
  //int categoryId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Productbloc.listenerStream.listen((event) {
      if(event is NavigatorToDetailPage)
      {
        print("CHUYEN SANG TRANG PAGE DETAIL");
        Navigator.of(context).pushNamed(
            Routes.productDetail, arguments: event.model
        );
      }
    });

    _categoryPrivateBloc.listenerStream.listen((event) {
      if (event is SelectCategoryPrivateEvent) {
        //
        Productbloc.add(LoadProductByStorePageEvent(
            request: GetProductModel(
                categoryId: event.categoryModelIsChoose.id,
                status: Status.Approved,
                StoreId: storeIdEdit,
                currPage: 1
            )));


        print("STORE ID :" + storeIdEdit.toString());
        //
        //categoryId = event.categoryModelIsChoose.id;
      }
    });


  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    RouteSettings settings = ModalRoute.of(context).settings;
    if (settings.arguments != null) {

      int storeId = settings.arguments as int;

      if(storeId != null)
        {
          print("đây là giá trị store ID mà ProductPage nhận được");
          storeIdEdit = storeId;
          //gọi bloc load và
          Productbloc.add(LoadProductByStorePageEvent(
              request: GetProductModel(
                  currPage: 1,
                  CategoryName: "",
                  NameOfProduct: "",
                  status: Status.Approved,
                  PriceFrom: null,
                  PriceTo: null,
                  StoreId: storeId)));
          // cả category
          _categoryPrivateBloc.add(LoadCategoryPrivateEvent(getCategoryModel: GetCategoryModel(storeId: storeId)));


              //LoadCategoryPrivateEvent(getCategoryModel: GetCategoryModel(StoreId: storeId))


        }
    }
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
              'Danh sách sản phẩm',
              style: TextStyle(color: Colors.black54, fontSize: Dimens.size23)
          ),
          backgroundColor: AppColors.primaryColor,
          centerTitle: true,
        ),
        body: BlocProvider.value(
          value: Productbloc,
          child: Column(children: [

            //gọi Widget category
            BlocProvider.value(
              value: _categoryPrivateBloc,
              child: BlocBuilder<CategoryPrivateBloc,CategoryPrivateState>(
                bloc: _categoryPrivateBloc,
                builder: (context, state) {
                  return state.listCategory.isEmpty
                      ? Text('no list cate')
                      : ListViewCategoryPrivate(listCategory: state.listCategory);
                },
              ),
            ),

            // BlocBuilder<ProductBloc,ProductState>(
            //   bloc: Productbloc,
            //     builder:(context, state) {
            //       return state.currentlistProduct.isEmpty
            //           ? Text('Chúng tôi sẽ có hàng sớm hơn')
            //           :Expanded(child: ListViewProduct());
            //     }, ),
          Expanded(child: ListViewProduct()),
          ]),
        )
        );
  }
}
