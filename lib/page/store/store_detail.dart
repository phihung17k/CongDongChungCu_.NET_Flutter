import 'package:congdongchungcu/bloc/store/store_event.dart';
import 'package:congdongchungcu/bloc/store/store_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dimens.dart';
import '../../router.dart';
import '/bloc/store/store_bloc.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../app_colors.dart';

class StoreDetail extends StatefulWidget {
  final StoreBloc storeBloc;
  StoreDetail(this.storeBloc);

  @override
  _StoreDetailState createState() => _StoreDetailState();
}

class _StoreDetailState extends State<StoreDetail> {
  StoreBloc get _storeBloc => widget.storeBloc;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    _storeBloc.listenerStream.listen((event) {
      if (event is NavigatorProductPageEvent) {
        print("CHUYEN TRANG");
        Navigator.of(context).pushReplacementNamed(
          Routes.product, arguments: event.storeId
        );
      }
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    RouteSettings settings = ModalRoute.of(context).settings;
    if (settings.arguments != null) {
      int storeId = settings.arguments as dynamic;
      //
      print("StoreId nhận từ những trang profile và store info: " +
          storeId.toString());
      if (storeId != null) {
        _storeBloc.add(GetStoreEvent(storeId));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: AppColors.primaryColor,
          // title: new Center(child: new Text(widget.title, textAlign: TextAlign.center)),
          title: Text(
              'Chi tiết Shop',
              style: TextStyle(
                  fontSize: Dimens.size23,
                  color: Colors.black)
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<StoreBloc,StoreState>(
          bloc: _storeBloc,
          builder: (context, state) {
            return state.storeOfCurrentResident.name == ""
                ? Text("kh có dữ liệu")
                : SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    color: Colors.grey[300],
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 30, horizontal: 20),
                          color: Colors.white,
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(right: 10),
                                child: CircleAvatar(
                                  radius: 40.0,
                                  // backgroundColor: Palette.facebookBlue,
                                  child: CircleAvatar(
                                    radius: 50.0,
                                    backgroundColor: Colors.grey[200],
                                    backgroundImage: ExactAssetImage(
                                        'assets/images/background.jpg'), //CachedNetworkImageProvider(imageUrl),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Dimens.size20),
                                child: Text(state.storeOfCurrentResident.name,
                                    style: TextStyle(
                                        fontSize: Dimens.size20,
                                        fontWeight: FontWeight.bold)),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                            color: Colors.white,
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.storefront),
                                          SizedBox(width: 10),
                                          Text('Sản phẩm:')
                                        ],
                                      ),
                                      SizedBox(width: Dimens.size10),
                                      Text('100'),
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey[800],
                                  height: 1,
                                ),

                                Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                  height: 40,
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        size: Dimens.size25,
                                      ),
                                      SizedBox(width: Dimens.size10),
                                      Text(
                                          'Địa chỉ của Shop: '
                                      ),
                                      SizedBox(width: Dimens.size5),
                                      Text(state.storeOfCurrentResident.address)
                                    ],
                                  ),
                                ),

                                Divider(
                                  color: Colors.grey[800],
                                  height: 1,
                                ),

                                Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                  height: 40,
                                  child: Row(
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.phone),
                                      SizedBox(width: 10),
                                      Text(state.storeOfCurrentResident.phone),
                                    ],
                                  ),
                                ),

                                Divider(
                                  color: Colors.grey[800],
                                  height: 1,
                                ),

                                Container(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 10),
                                  height: 40,
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.timer,
                                        size: Dimens.size25,
                                      ),
                                      SizedBox(width: Dimens.size10),
                                      Text(
                                          'Giờ mở cửa: '
                                      ),

                                      SizedBox(width: Dimens.size5),

                                      Text("${state.storeOfCurrentResident.openingTime.hour}:00"),

                                      SizedBox(width: Dimens.size20),

                                      Text(
                                          'Giờ đóng cửa: '
                                      ),

                                      SizedBox(width: Dimens.size5),

                                      Text("${state.storeOfCurrentResident.closingTime.hour}:00"),

                                    ],
                                  ),
                                ),

                              ],
                            )),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),

                  InkWell(
                    onTap: () {
                      _storeBloc.add(NavigatorProductPageEvent(state.storeOfCurrentResident.storeId));
                    },
                    child: Container(
                        padding: EdgeInsets.all(20),
                        color: Colors.grey[200],
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Tất Cả Sản Phẩm',
                                style: TextStyle(
                                    fontSize: Dimens.size20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor),
                              )
                            ])),
                  ),
                ],
              ),
            );
          },
        ));
  }
}


