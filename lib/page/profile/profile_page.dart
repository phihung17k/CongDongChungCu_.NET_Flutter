import 'dart:ui';
import 'package:congdongchungcu/bloc/profile/profile_bloc.dart';
import 'package:congdongchungcu/bloc/profile/profile_event.dart';
import 'package:congdongchungcu/bloc/profile/profile_state.dart';
import 'package:congdongchungcu/firebase_utils.dart';
import 'package:congdongchungcu/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../app_colors.dart';
import '../../dimens.dart';
import '../../router.dart';

class ProfilePage extends StatefulWidget {
  final ProfileBloc bloc;

  // final StoreBloc storeBloc;

  ProfilePage(this.bloc);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  ProfileBloc get _bloc => widget.bloc;

  // StoreBloc get _storeBloc => widget.storeBloc;

  // int _storeId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc.listenerStream.listen((event) {
      if (event is SendStoreIdToMyShopEvent) {
        print("chuyển sang trang my shop");
        print("Store Id : " + event.storeId.toString());
        // _storeId = event.storeId;
        // print("storeId: ${event.storeId}");
        if(event.storeId == 0) {
          Navigator.of(context).pushNamed(Routes.editStore);
        }
        else {
          Navigator.of(context)
              .pushNamed(Routes.storePersonal, arguments: event.storeId);
        }
      }
    });
    _bloc.add(AutoLoadProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    UserRepository user = GetIt.I.get<UserRepository>();
    return BlocBuilder<ProfileBloc, ProfileState>(
      bloc: _bloc,
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text("Trang cá nhân",
                  style: TextStyle(
                      color: Colors.black54, fontSize: Dimens.size23)),
              centerTitle: true,
              backgroundColor: AppColors.primaryColor,
            ),
            body: ListView(children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30.0),
                child: Align(
                    child: Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user.imagePath),
                      radius: 65.0, // 65
                    ),
                    Positioned(
                        bottom: 5,
                        right: 5,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.editProfile);
                          },
                          child: ClipOval(
                              child: Container(
                                  padding: EdgeInsets.all(8.0),
                                  color: Colors.blue[400],
                                  child: Icon(Icons.edit,
                                      size: 20, color: Colors.white))),
                        ))
                  ],
                )),
              ),
              Container(
                color: Colors.grey[100],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Thông tin cá nhân',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          ElevatedButton(
                              onPressed: () async {
                                print("onTap called.");
                                //tạo event navigate to storepersonal
                                // _storeBloc.add(NavigatorToMyShopEvent());
                                _bloc.add(NavigatorToMyShopEvent());
                                // here
                                // _storeBloc.listenerStream.listen((event) {
                                //     if(event is SendStoreIdToMyShopEvent)
                                //     {
                                //       print("chuyển sang trang my shop");
                                //       print("Store Id : " + event.storeId.toString());
                                //       storeId = event.storeId;
                                //       print("storeId: ${storeId}");
                                //     }
                                //   });
                                // await Future.delayed(
                                //     Duration(seconds: 0, milliseconds: 3000));
                                // print("storeId outside if: ${_storeId}");
                                // Navigator.of(context).pushNamed(
                                //     Routes.storePersonal,
                                //     arguments: _storeId);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                              ),
                              child: Container(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.storefront,
                                      size: Dimens.size20,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("Shop của tôi")
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: Dimens.size10),
                      child: Card(
                        elevation: 4,
                        child: Column(children: [
                          Padding(
                            padding: EdgeInsets.all(Dimens.size10),
                            child: Row(children: [
                              Icon(Icons.info_outline),
                              //account_circle_outlined
                              SizedBox(
                                width: Dimens.size30,
                              ),
                              Text(
                                state.fullname,
                                style: TextStyle(fontSize: Dimens.size16),
                              )
                            ]),
                          ),
                          Divider(
                            height: 0.6,
                            color: Colors.black,
                          ),
                          Padding(
                            padding: EdgeInsets.all(Dimens.size10),
                            child: Row(children: [
                              Icon(Icons.alternate_email),
                              SizedBox(
                                width: Dimens.size30,
                              ),
                              Text(
                                state.email,
                                style: TextStyle(fontSize: Dimens.size16),
                              )
                            ]),
                          ),
                          Divider(
                            height: 0.6,
                            color: Colors.black,
                          ),
                          Padding(
                            padding: EdgeInsets.all(Dimens.size10),
                            child: Row(children: [
                              Icon(Icons.phone),
                              SizedBox(
                                width: Dimens.size30,
                              ),
                              Text(
                                state.phone,
                                style: TextStyle(fontSize: 16),
                              )
                            ]),
                          ),
                          Divider(
                            height: 0.6,
                            color: Colors.black,
                          ),
                          Padding(
                            padding: EdgeInsets.all(Dimens.size10),
                            child: Row(children: [
                              Icon(Icons.location_on),
                              SizedBox(
                                width: Dimens.size30,
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${user.selectedResident.buildingModel.name}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    '${user.selectedResident.apartmentModel.name}',
                                    style: TextStyle(fontSize: 16),
                                  )
                                ],
                              )
                            ]),
                          )
                        ]),
                      ),
                    ),
                    user.selectedResident.isAdmin
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Dimens.size20,
                                    vertical: Dimens.size10),
                                child: Row(children: [
                                  Text(
                                    'Quản lý chung cư',
                                    style: TextStyle(
                                      fontSize: Dimens.size18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]),
                              ),
                              Card(
                                margin: EdgeInsets.symmetric(
                                    horizontal: Dimens.size15),
                                elevation: 4,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: Dimens.size10,
                                          bottom: Dimens.size5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context, Routes.poi_manage);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: AppColors.primaryColor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0)),
                                            ),
                                            child: Container(
                                              width: 130,
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.insert_emoticon,
                                                    size: Dimens.size20,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text("Quản lý POI")
                                                ],
                                              ),
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              // Navigator.pushNamed(context, Routes.storePersonal);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: AppColors.primaryColor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0)),
                                            ),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).pushNamed(
                                                    Routes.news_manage);
                                              },
                                              child: Container(
                                                width: 130,
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.article_outlined,
                                                      size: Dimens.size20,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text("Quản lý News")
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: Dimens.size5,
                                          bottom: Dimens.size10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pushNamed(
                                                  Routes.post_manage);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: AppColors.primaryColor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0)),
                                            ),
                                            child: Container(
                                              width: 130,
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.paste_outlined,
                                                    size: Dimens.size20,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text("Quản lý Posts")
                                                ],
                                              ),
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              // Navigator.pushNamed(context, Routes.storePersonal);
                                              Navigator.pushNamed(context,
                                                  Routes.listStoreManagement);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: AppColors.primaryColor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0)),
                                            ),
                                            child: Container(
                                              width: 130,
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.storefront,
                                                    size: Dimens.size20,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text("Quản lý Stores")
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Dimens.size20,
                                    vertical: Dimens.size10),
                                child: Row(children: [
                                  Text(
                                    'Cài đặt',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    // textAlign: TextAlign.start,
                                  ),
                                ]),
                              ),
                            ],
                          )
                        : SizedBox(
                            height: Dimens.size15,
                          ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                        elevation: 4,
                        child: Column(children: [
                          Padding(
                            padding: EdgeInsets.all(
                              Dimens.size10,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.profileSelection);
                              },
                              child: Row(children: [
                                Icon(
                                  Icons.account_circle,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: Dimens.size30,
                                ),
                                Text(
                                  "Chọn cư dân",
                                  style: TextStyle(
                                      fontSize: Dimens.size16,
                                      color: Colors.black45),
                                ),
                              ]),
                            ),
                          ),
                          Divider(
                            height: 0.6,
                            color: Colors.black,
                          ),
                          Padding(
                            padding: EdgeInsets.all(
                              Dimens.size10,
                            ),
                            child: Row(children: [
                              Icon(
                                Icons.settings,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: Dimens.size30,
                              ),
                              Text(
                                "Cài đặt chung",
                                style: TextStyle(
                                    fontSize: Dimens.size16,
                                    color: Colors.black45),
                              ),
                            ]),
                          ),
                          Divider(
                            height: 0.6,
                            color: Colors.black,
                          ),
                          Padding(
                            padding: EdgeInsets.all(
                              Dimens.size10,
                            ),
                            child: Row(children: [
                              Icon(
                                Icons.lock,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: Dimens.size30,
                              ),
                              Text(
                                "Quyền riêng tư",
                                style: TextStyle(
                                    fontSize: Dimens.size16,
                                    color: Colors.black45),
                              ),
                            ]),
                          ),
                          Divider(
                            height: 0.6,
                            color: Colors.black,
                          ),
                          Padding(
                            padding: EdgeInsets.all(
                              Dimens.size10,
                            ),
                            child: Row(children: [
                              Icon(
                                Icons.dashboard_customize,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: Dimens.size30,
                              ),
                              Text(
                                "Hỗ trợ",
                                style: TextStyle(
                                    fontSize: Dimens.size16,
                                    color: Colors.black45),
                              ),
                            ]),
                          )
                        ]),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        // _bloc.add(LogoutEvent());
                        await FirebaseUtils.logout();
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Color.fromRGBO(240, 103, 103, 1),
                          ),
                          margin: EdgeInsets.only(
                              top: Dimens.size12,
                              right: Dimens.size12,
                              bottom: Dimens.size28,
                              left: Dimens.size12),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.logout,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "Đăng xuất",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ],
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ]));
      },
    );
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}
