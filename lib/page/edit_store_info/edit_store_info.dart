import 'package:congdongchungcu/bloc/dialog_widget/dialog_widget_bloc.dart';
import 'package:flutter/material.dart';
import 'package:congdongchungcu/bloc/edit_store_bloc/edit_store_bloc.dart';
import 'package:congdongchungcu/bloc/edit_store_bloc/edit_store_event.dart';
import 'package:congdongchungcu/bloc/edit_store_bloc/edit_store_state.dart';
import 'package:congdongchungcu/models/enum.dart';
import 'package:congdongchungcu/models/storedto_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../../app_colors.dart';
import '../../dimens.dart';
import '../../router.dart';
import 'widgets/dialog_widget.dart';

class EditStoreInfo extends StatefulWidget {
  //const EditStore({Key key}) : super(key: key);
  final EditStoreBloc editStoreBloc;

  EditStoreInfo({this.editStoreBloc});

  @override
  _EditStoreInfoState createState() => _EditStoreInfoState();
}

class _EditStoreInfoState extends State<EditStoreInfo> {

  final _formKeyStoreName = GlobalKey<FormState>();
  final _formKeyStoreAddress = GlobalKey<FormState>();
  final _formKeyStorePhone = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController openTimeController = TextEditingController(text: "0:00");
  final TextEditingController closeTimeController = TextEditingController(text: "0:00");

  //
  EditStoreBloc get _editStoreBloc => widget.editStoreBloc;

  //
  DateTime now = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _editStoreBloc.listenerStream.listen((event) {
      if (event is NavigateToStorePageEvent) {
        print("navigateToStorePage khi tạo shop thành công");
        Navigator.of(context).pushReplacementNamed(Routes.storePersonal,
            arguments: event.storeId);
      }
      if (event is PassDataToStorePersonalEvent) {
        print("navigateToStorePage khi tạo shop thành công");
        print("store id trả ra khi update sotre thành công: " +
            event.storeId.toString());

        Navigator.of(context).pop(event.storeId);
      }
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    RouteSettings settings = ModalRoute.of(context).settings;
    if (settings.arguments != null) {
      StoreDTO store = settings.arguments as StoreDTO;

      if (store != null) {
        //add event set state cho
        _editStoreBloc.add(RecieveStoreDTO(storeDto: store));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditStoreBloc, EditStoreState>(
      bloc: _editStoreBloc,
      builder: (context, state) {
        //
        String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
        //
        if (state.storeIsChoose.name.isEmpty) {
          //cho text rỗng
          nameController.text = "";
          addressController.text = "";
          phoneController.text = "";
          // openTimeController.text = formattedDate;
          // closeTimeController.text = formattedDate;
        }

        if (state.storeIsChoose.name.isNotEmpty) {
          //cho text fill nếu có data
          nameController.text = state.storeIsChoose.name;
          addressController.text = state.storeIsChoose.address;
          phoneController.text = state.storeIsChoose.phone;
          openTimeController.text = "${state.storeIsChoose.openingTime.hour}:00";
          closeTimeController.text = "${state.storeIsChoose.closingTime.hour}:00";
        }

        return state.storeIsChoose.name.isEmpty
            ? Scaffold(
                appBar: AppBar(
                  iconTheme: IconThemeData(color: Colors.black),
                  title: Text('Tạo mới cửa hàng',
                      style: TextStyle(
                          color: Colors.black54, fontSize: Dimens.size23)),
                  backgroundColor: AppColors.primaryColor,
                  centerTitle: true,
                ),
                body: ListView(
                  padding: EdgeInsets.symmetric(horizontal: Dimens.size22),
                  physics: BouncingScrollPhysics(),
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      margin: EdgeInsets.symmetric(vertical: Dimens.size30),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage('assets/images/background.jpg'),
                            fit: BoxFit.contain),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tên cửa hàng',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Dimens.size16),
                        ),
                        //SizedBox(height: Dimens.size15),
                        Form(
                          key: _formKeyStoreName,
                          child:  Padding(
                            padding: EdgeInsets.all(Dimens.size8),
                            child: TextFormField(
                              controller: nameController,
                              maxLines: 1,
                              maxLength: 50,
                              //initialValue: model.title,
                              keyboardType: TextInputType.multiline,
                              validator: (value) {
                                if (value.isEmpty || value.length < 10) {
                                  return 'Nhập ít nhất 10 ký tự';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                if(_formKeyStoreName.currentState.validate())
                                {
                                  //nameController.text = value;

                                }
                              },
                              decoration: InputDecoration(
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.red,
                                      width: Dimens.size1),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: Dimens.size1),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                hintText: 'Nhập tên cửa hàng ',
                              ),
                            ),
                          ),
                        ),

                        Text(
                          'Địa chỉ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Dimens.size16),
                        ),
                        //SizedBox(height: Dimens.size15),
                        Form(
                          key: _formKeyStoreAddress,
                          child: Padding(
                            padding: EdgeInsets.all(Dimens.size8),
                            child: TextFormField(
                              controller: addressController,
                              maxLines: 1,
                              maxLength: 50,
                              keyboardType: TextInputType.multiline,
                              validator: (value) {
                                if (value.isEmpty || value.length < 3) {
                                  return 'Nhập ít nhất 3 ký tự';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.red,
                                      width: Dimens.size1),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: Dimens.size1),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                hintText: 'Nhập địa chỉ cửa hàng ',
                              ),
                            ),
                          ),
                        ),


                        Text(
                          'Số điện thoại',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Dimens.size16),
                        ),
                        Form(
                          key: _formKeyStorePhone,
                          child:Padding(
                            padding: EdgeInsets.all(Dimens.size8),
                            child: TextFormField(
                              controller: phoneController,
                              maxLines: 1,
                              maxLength: 10,
                              keyboardType: TextInputType.multiline,
                              validator: (value) {
                                if (value.isEmpty || value.length < 10) {
                                  return 'Nhập ít nhất 10 số';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.red,
                                      width: Dimens.size1),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: Dimens.size1),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                hintText: 'Nhập số điện thoại cửa hàng ',
                              ),
                            ),
                          ),),


                        Text(
                          'Giờ mở cửa',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Dimens.size16),
                        ),
                        SizedBox(height: Dimens.size15),
                        TextField(
                          controller: openTimeController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(Dimens.size15),
                            ),
                          ),
                          maxLines: 1,
                          readOnly: true,
                          onTap: () async{
                            int hour = await showDialog(
                              context: context,
                              builder: (context) {
                                return DialogWidget(
                                    GetIt.I.get<DialogWidgetBloc>());
                              },
                            );
                            openTimeController.text = "$hour:00";
                          },
                        ),
                        SizedBox(height: Dimens.size15),
                        Text(
                          'Giờ đóng cửa',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Dimens.size16),
                        ),
                        SizedBox(height: Dimens.size15),
                        TextField(
                          controller: closeTimeController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(Dimens.size15),
                            ),
                          ),
                          maxLines: 1,
                          readOnly: true,
                          onTap: () async{
                            int hour = await showDialog(
                              context: context,
                              builder: (context) {
                                return DialogWidget(
                                    GetIt.I.get<DialogWidgetBloc>());
                              },
                            );
                            closeTimeController.text = "$hour:00";
                          },
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        if(_formKeyStoreName.currentState.validate()){
                          //validate address
                          if(_formKeyStoreAddress.currentState.validate()){
                            //
                            if(_formKeyStorePhone.currentState.validate())
                              {
                                print("Create");
                                print("name_store: " + nameController.text);
                                print("address: " + addressController.text);
                                print("phone: " + phoneController.text);
                                print("opening-time: " + openTimeController.text);
                                print("closing-time: " + closeTimeController.text);
                                // DateTime ot = DateTime.parse(openTimeController.text);
                                // DateTime ct = DateTime.parse(closeTimeController.text);
                                DateTime time = DateTime.now();
                                DateTime ot = DateTime(
                                    time.year,
                                    time.month,
                                    time.day,
                                    int.parse(openTimeController.text.split(":")[0])
                                );
                                DateTime ct = DateTime(
                                    time.year,
                                    time.month,
                                    time.day,
                                    int.parse(closeTimeController.text.split(":")[0])
                                );
                                print("open time $ot ---------------- close time $ct");

                                //add event create store
                                _editStoreBloc.add(AddNewStoreEvent(StoreDTO(
                                    name: nameController.text,
                                    address: addressController.text,
                                    phone: phoneController.text,
                                    openingTime: ot,
                                    closingTime: ct)));
                              }
                          }
                        }
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                            color: Color.fromRGBO(240, 103, 103, 1),
                          ),
                          margin: EdgeInsets.symmetric(
                              horizontal: 50.0, vertical: Dimens.size30),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: 5),
                                Text(
                                  "Tạo mới cửa hàng",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )
                              ],
                            ),
                          )),
                    )
                  ],
                ),
              )
            : Scaffold(
                appBar: AppBar(
                  iconTheme: IconThemeData(color: Colors.black),
                  title: Text('Thông tin cửa hàng',
                      style: TextStyle(
                          color: Colors.black54, fontSize: Dimens.size23)),
                  backgroundColor: AppColors.primaryColor,
                  centerTitle: true,
                ),
                body: ListView(
                  padding: EdgeInsets.symmetric(horizontal: Dimens.size22),
                  physics: BouncingScrollPhysics(),
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      margin: EdgeInsets.symmetric(vertical: Dimens.size30),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage('assets/images/background.jpg'),
                            fit: BoxFit.contain),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [


                        Text(
                          'Tên cửa hàng',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Dimens.size16),
                        ),
                        Form(
                          key: _formKeyStoreName,
                          child:  Padding(
                            padding: EdgeInsets.all(Dimens.size8),
                            child: TextFormField(
                              controller: nameController,
                              maxLines: 1,
                              maxLength: 50,
                              //initialValue: model.title,
                              keyboardType: TextInputType.multiline,
                              validator: (value) {
                                if (value.isEmpty || value.length < 10) {
                                  return 'Nhập ít nhất 10 ký tự';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                if(_formKeyStoreName.currentState.validate())
                                  {
                                    //nameController.text = value;

                                  }
                              },
                              decoration: InputDecoration(
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.red,
                                      width: Dimens.size1),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: Dimens.size1),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                hintText: 'Nhập tên cửa hàng ',
                              ),
                            ),
                          ),
                        ),

                        Text(
                          'Địa chỉ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Dimens.size16),
                        ),
                        Form(
                            key: _formKeyStoreAddress,
                            child: Padding(
                              padding: EdgeInsets.all(Dimens.size8),
                              child: TextFormField(
                                controller: addressController,
                                maxLines: 1,
                                maxLength: 50,
                                keyboardType: TextInputType.multiline,
                                validator: (value) {
                                  if (value.isEmpty || value.length < 3) {
                                    return 'Nhập ít nhất 3 ký tự';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red,
                                        width: Dimens.size1),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: Dimens.size1),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  hintText: 'Nhập địa chỉ cửa hàng ',
                                ),
                              ),
                            ),
                        ),


                        Text(
                          'Số điện thoại',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Dimens.size16),
                        ),
                        Form(
                          key: _formKeyStorePhone,
                        child:Padding(
                          padding: EdgeInsets.all(Dimens.size8),
                          child: TextFormField(
                            controller: phoneController,
                            maxLines: 1,
                            maxLength: 10,
                            keyboardType: TextInputType.multiline,
                            validator: (value) {
                              if (value.isEmpty || value.length < 10) {
                                return 'Nhập ít nhất 10 số';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.red,
                                    width: Dimens.size1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: Dimens.size1),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              hintText: 'Nhập số điện thoại cửa hàng ',
                            ),
                          ),
                        ),),


                        Text(
                          'Giờ mở cửa',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Dimens.size16),
                        ),
                        SizedBox(height: Dimens.size15),
                        TextField(
                          controller: openTimeController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(Dimens.size15),
                            ),
                          ),
                          maxLines: 1,
                          readOnly: true,
                          onTap: () async {
                            int hour = await showDialog(
                              context: context,
                              builder: (context) {
                                return DialogWidget(
                                    GetIt.I.get<DialogWidgetBloc>());
                              },
                            );
                            openTimeController.text = "$hour:00";
                          },
                        ),
                        SizedBox(height: Dimens.size15),
                        Text(
                          'Giờ đóng cửa',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Dimens.size16),
                        ),
                        SizedBox(height: Dimens.size15),
                        TextField(
                          controller: closeTimeController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(Dimens.size15),
                            ),
                          ),
                          maxLines: 1,
                          readOnly: true,
                          onTap: () async{
                            int hour = await showDialog(
                              context: context,
                              builder: (context) {
                                return DialogWidget(
                                    GetIt.I.get<DialogWidgetBloc>());
                              },
                            );
                            closeTimeController.text = "$hour:00";
                          },
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        //validate
                        if(_formKeyStoreName.currentState.validate())
                        {
                          //address
                          if(_formKeyStoreAddress.currentState.validate())
                            {
                              //phone
                              if(_formKeyStorePhone.currentState.validate())
                                {
                                  print("Update");
                                  // print("store id: "+ state.storeIsChoose.storeId.toString());
                                  // print("name: "+ nameController.text);

                                  print("opening-time: " + openTimeController.text);
                                  print("closing-time: " + closeTimeController.text);
                                  //parse sang datetime
                                  // DateTime ot = DateTime.parse(openTimeController.text);
                                  // DateTime ct = DateTime.parse(closeTimeController.text);
                                  DateTime time = DateTime.now();
                                  DateTime ot = DateTime(
                                      time.year,
                                      time.month,
                                      time.day,
                                      int.parse(openTimeController.text.split(":")[0])
                                  );
                                  DateTime ct = DateTime(
                                      time.year,
                                      time.month,
                                      time.day,
                                      int.parse(closeTimeController.text.split(":")[0])
                                  );
                                  print("open time $ot ---------------- close time $ct");
                                  // print("address: " + addressController.text);
                                  // print("phone: " + phoneController.text);
                                  // //kh cho update status
                                  // print("status: "+ state.storeIsChoose.status.toString());
                                  //bloc
                                  _editStoreBloc.add(UpdateStoreEvent(StoreDTO(
                                      storeId: state.storeIsChoose.storeId,
                                      status: state.storeIsChoose.status,
                                      closingTime: ct,
                                      openingTime: ot,
                                      phone: phoneController.text,
                                      address: addressController.text,
                                      name: nameController.text)));
                                }
                            }
                        }
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                            color: Color.fromRGBO(240, 103, 103, 1),
                          ),
                          margin: EdgeInsets.symmetric(
                              horizontal: 50.0, vertical: 30.0),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Cập nhật cửa hàng",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
              );
      },
    );
  }
}
