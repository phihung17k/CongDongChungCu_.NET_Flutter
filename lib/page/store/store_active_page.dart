import 'package:congdongchungcu/bloc/edit_store_bloc/edit_store_bloc.dart';
import 'package:congdongchungcu/bloc/edit_store_bloc/edit_store_event.dart';
import 'package:congdongchungcu/bloc/edit_store_bloc/edit_store_state.dart';
import 'package:congdongchungcu/models/storedto_model.dart';
import 'package:congdongchungcu/page/store/widgets/icon_btn_with_counter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_colors.dart';
import '../../dimens.dart';
import '../../router.dart';

class StoreActivePage extends StatefulWidget {
  //const StoreActivePage({Key? key}) : super(key: key);
  final EditStoreBloc editStoreBloc;

  StoreActivePage({this.editStoreBloc});

  @override
  _StoreActivePageState createState() => _StoreActivePageState();
}

class _StoreActivePageState extends State<StoreActivePage> {
  EditStoreBloc get _editStoreBloc => widget.editStoreBloc;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    _editStoreBloc.listenerStream.listen((event) {

      if(event is PassDataToStorePersonalEvent)
      {

        print("store id trả ra khi kích hoạt store thành công: "+ event.storeId.toString());
        Navigator.of(context).pushReplacementNamed(Routes.storePersonal,arguments: event.storeId);
      }
    });


  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    RouteSettings settings = ModalRoute.of(context).settings;
    if (settings.arguments != null) {

      StoreDTO dto = settings.arguments as StoreDTO;
      //
      if(dto != null)
        {
          _editStoreBloc.add(RecieveStoreDTO(storeDto: dto));
        }
    }

  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditStoreBloc,EditStoreState>(
        bloc: _editStoreBloc,
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                title: Text('My Shop',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25)),
                actions: [
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
                  )
                ],
                backgroundColor:
                    AppColors.primaryColor, //backgroundCategoryCard
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Column(
                      children: [
                        Text("Shop Hiện Tại Của Bạn Đã Bị Admin Ban"),
                        InkWell(
                          onTap: () {
                              //gọi hàm update
                               state.storeIsChoose.status = false;
                               //
                               print("Giá trị hiện tại của store sau khi kích hoạt : " + state.storeIsChoose.status.toString());
                              _editStoreBloc.add(UpdateStoreEvent(state.storeIsChoose));
                          },
                          child: Text("Nhấn vào đây để kích hoạt Shop!"),
                        )
                      ],
                    ),
                  ]),
                ],
              ));
        });
  }
}
