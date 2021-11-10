import 'package:congdongchungcu/bloc/category/category_bloc.dart';
import 'package:congdongchungcu/bloc/category/category_event.dart';
import 'package:congdongchungcu/bloc/category/category_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../router.dart';
import 'widgets/list_view_category.dart';

class CategoryPage extends StatefulWidget {
  CategoryBloc Categorybloc;

  CategoryPage({this.Categorybloc});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  CategoryBloc get _Categorybloc => widget.Categorybloc;


  @override
  void initState() {
    //load dữ liệu theo store đó
    //sẽ nhận đc cái store id đó
  }


  //nhận xong chuyển dữ liệu luôn kích hoạt event
  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    //nhận agrument của bên trang product để load category có trong storeId đó
    RouteSettings settings = ModalRoute.of(context).settings;
    if(settings.arguments != null){
      int storeId = settings.arguments as int;

      print("Category nhận storeId từ bên productpage : ${storeId}");

      //nhận và get category của stroe id đó luôn
      _Categorybloc.add(RecieveDataFromProductPageEvent(storeId: storeId));


    }
    super.didChangeDependencies();
  }



  @override
  Widget build(BuildContext context) {

    // //sau khi emit ra sẽ build lại thì lúc này check event luôn
    // _Categorybloc.listenerStream.listen((event) {
    //   if (event is PassDataCategoryIsChooseEvent) {
    //       // navigate kèm theo cái agrument cái loại đc chọn
    //     Navigator.of(context).pushReplacementNamed(
    //       Routes.product, arguments: event.categoryModel
    //     );
    //   }
    //  //gửi lại cho trang product page
    //   if(event is PassDataCategoryEvent)
    //     {
    //       print("Chuyển listCate lại cho trang Product Page");
    //       Navigator.of(context).pushReplacementNamed(
    //           Routes.product, arguments: event.listCategory
    //       );
    //     }
    // });


    return BlocProvider.value(
      value: _Categorybloc,
      child: BlocBuilder<CategoryBloc,CategoryState>(
        bloc: _Categorybloc,
        builder: (context, state) {
          return state.listCategory.isEmpty
              ? Text('no list cate')
              :ListViewCategory(listCategory: state.listCategory);
        },
      )
    );
  }
}
