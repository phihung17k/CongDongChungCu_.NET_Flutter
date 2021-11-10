import 'package:congdongchungcu/bloc/store/store_bloc.dart';
import 'package:congdongchungcu/bloc/store/store_event.dart';
import 'package:congdongchungcu/router.dart';
import 'package:flutter/material.dart';
import 'package:congdongchungcu/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../dimens.dart';
import 'widgets/list_view_store.dart';


class ListStorePage extends StatefulWidget {
  // const ListStore({Key key}) : super(key: key);

  final StoreBloc storeBloc;

  ListStorePage({this.storeBloc});

  @override
  _ListStorePageState createState() => _ListStorePageState();
}

class _ListStorePageState extends State<ListStorePage> {
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
    });

  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();


  }

  @override
  Widget build(BuildContext context) {

    return BlocProvider.value(
        value: _storeBloc,
        child: Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.black),
              title: Text(
                  'Danh sách cửa hàng',
                  style: TextStyle(color: Colors.black54, fontSize: Dimens.size23)
              ),
              backgroundColor: AppColors.primaryColor,
              centerTitle: true,
            ),
            body:  ListViewStore()

        ),
    );

  }
}
