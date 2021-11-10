import 'package:congdongchungcu/bloc/store/store_bloc.dart';
import 'package:congdongchungcu/bloc/store/store_event.dart';
import 'package:congdongchungcu/page/store/widgets/list_view_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_colors.dart';
import '../../dimens.dart';
import '../../router.dart';
import 'widgets/list_view_store_management.dart';


class ListStoreManagement extends StatefulWidget {
  //const ListStoreManagement({Key? key}) : super(key: key);

  final StoreBloc storeBloc;

  ListStoreManagement({this.storeBloc});

  @override
  _ListStoreManagementState createState() => _ListStoreManagementState();
}

class _ListStoreManagementState extends State<ListStoreManagement> {
  StoreBloc get _storeBloc => widget.storeBloc;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("Vừa vào là add list Store ngay lập tức");
    _storeBloc.add(LoadStoreDefault());
    //
    _storeBloc.listenerStream.listen((event) {
      if(event is NavigatorToStoreDetail)
      {
        Navigator.pushNamed(context, Routes.storeDetail, arguments: event.storeId);
      }

      if(event is NavigateToProductPageManagementEvent)
        {
          print("Navigate To ProductPageManagement Listener");
          Navigator.pushNamed(context, Routes.productpageManagement, arguments: event.storeId);
        }

    });

  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _storeBloc,
      child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(
                'Danh sách cửa hàng cần duyệt',
                style: TextStyle(color: Colors.black54, fontSize: Dimens.size23)
            ),
            backgroundColor: AppColors.primaryColor,
            centerTitle: true,
          ),
          body:  ListViewStoreManagement()

      ),
    );
  }
}
