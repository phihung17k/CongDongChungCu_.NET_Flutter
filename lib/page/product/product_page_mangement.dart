import 'package:congdongchungcu/bloc/category/category_bloc.dart';
import 'package:congdongchungcu/bloc/category/category_event.dart';
import 'package:congdongchungcu/bloc/category/category_state.dart';
import 'package:congdongchungcu/category_private/category_private_bloc.dart';
import 'package:congdongchungcu/category_private/category_private_event.dart';
import 'package:congdongchungcu/category_private/category_private_state.dart';
import 'package:congdongchungcu/models/category_model/category_model.dart';
import 'package:congdongchungcu/models/category_model/get_category_model.dart';
import 'package:congdongchungcu/models/enum.dart';
import 'package:congdongchungcu/models/product_model/get_product_model.dart';
import 'package:congdongchungcu/models/product_model/product_agrument.dart';
import 'package:congdongchungcu/page/category/category_page.dart';
import 'package:congdongchungcu/page/category/widgets/list_view_category.dart';
import 'package:congdongchungcu/page/category/widgets/list_view_category_private.dart';
import 'package:congdongchungcu/page/product/widgets/listview_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../app_colors.dart';
import '../../dimens.dart';
import '../../router.dart';
import '/bloc/productBloc/product_event.dart';
import '/bloc/productBloc/product_bloc.dart';
import 'widgets/listview_product_mangement.dart';

class ProductPageManagement extends StatefulWidget {
  final ProductBloc Productbloc;

  final CategoryPrivateBloc categoryPrivateBloc;


  ProductPageManagement({this.Productbloc, this.categoryPrivateBloc});

  @override
  _ProductPageManagementState createState() => _ProductPageManagementState();
}

class _ProductPageManagementState extends State<ProductPageManagement> {
  ProductBloc get Productbloc => widget.Productbloc;

  CategoryPrivateBloc get _categoryPrivateBloc => widget.categoryPrivateBloc;



  int storeIdEdit;
  //int categoryId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Productbloc.listenerStream.listen((event) async{
      if(event is NavigatorToDetailPage)
      {
        print("CHUYEN SANG TRANG PAGE DETAIL");
      storeIdEdit =  await Navigator.of(context).pushNamed(
            Routes.productDetailManagement, arguments: event.model
        ) as int;

      if(storeIdEdit > 0)
        {
          Productbloc.add(LoadProductByStorePageEvent(
              request: GetProductModel(
                  currPage: 1,
                  CategoryName: "",
                  NameOfProduct: "",
                  status: Status.NotApproved,
                  PriceFrom: null,
                  PriceTo: null,
                  StoreId: storeIdEdit)));
          //
          _categoryPrivateBloc.add(LoadCategoryPrivateEvent(getCategoryModel: GetCategoryModel(storeId: storeIdEdit)));


        }
      }
    });

    _categoryPrivateBloc.listenerStream.listen((event) {
      if (event is SelectCategoryPrivateEvent) {
        //
        Productbloc.add(LoadProductByStorePageEvent(
            request: GetProductModel(
                categoryId: event.categoryModelIsChoose.id,
                status: Status.NotApproved,
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
        print("đây là giá trị store ID mà ProductPageManagement nhận được");
        storeIdEdit = storeId;
        //gọi bloc load và
        Productbloc.add(LoadProductByStorePageEvent(
            request: GetProductModel(
                currPage: 1,
                CategoryName: "",
                NameOfProduct: "",
                status: Status.NotApproved,
                PriceFrom: null,
                PriceTo: null,
                StoreId: storeId)));
        //
        _categoryPrivateBloc.add(LoadCategoryPrivateEvent(getCategoryModel: GetCategoryModel(storeId: storeId)));

      }


    }
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
              'Danh sách Product chờ duyệt',
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


            Expanded(child: ListViewProductMangement())


          ]),
        )
    );
  }
}
