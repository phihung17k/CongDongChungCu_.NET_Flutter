import 'package:congdongchungcu/bloc/store/store_bloc.dart';
import 'package:congdongchungcu/bloc/store_main/store_main_bloc.dart';

import '../../bloc/news/news_bloc.dart';

import 'package:congdongchungcu/bloc/poi/poi_bloc.dart';
import 'package:congdongchungcu/bloc/post/post_bloc.dart';
import 'dart:async';

import 'package:congdongchungcu/bloc/profile/profile_bloc.dart';
import 'package:congdongchungcu/page/main_page/widgets/component_button.dart';
import 'package:congdongchungcu/page/post/post_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../app_colors.dart';
import '../../bloc/poi/poi_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../bloc/main/main_bloc.dart';
import '../../bloc/main/main_event.dart';
import '../../bloc/main/main_state.dart';
import '../../log.dart';
import '../../main.dart';
import '../store/store_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../router.dart';
import '../news/news_page.dart';
import '../poi/poi_page.dart';
import '../profile/profile_page.dart';

class MainPage extends StatefulWidget {
  final MainBloc _bloc;

  const MainPage(this._bloc, {Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController _pageController;
  StreamSubscription _listener;
  StreamSubscription keyboardSubscription;
  KeyboardVisibilityController keyboardVisibilityController =
      KeyboardVisibilityController();

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  MainBloc get bloc => widget._bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: bloc.state.currentPageIndex);

    bloc.listenerStream.listen((event) {
      if (event is SwitchingPageEvent) {
        Navigator.of(context).pushNamed(Routes.test);
      }
    });

    _listener = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        //sign out
        Navigator.pushReplacementNamed(context, Routes.login);
      }
    });

    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((visible) {
      if (visible) {
        bloc.add(HidingFloatingActionButtonEvent());
      } else {
        bloc.add(ShowingFloatingActionButtonEvent());
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("FirebaseMessaging.onMessage ${message.notification.title}");
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(channel.id, channel.name,
                  importance: Importance.high,
                  channelDescription: channel.description,
                  icon: '@mipmap/ic_launcher',
                  color: AppColors.primaryColor),
            ));
      }
    });

    FirebaseMessaging.instance.getInitialMessage().then((value) {
      if (value != null) {
        print("FirebaseMessaging.instance.getInitialMessage()");
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(
          "FirebaseMessaging.onMessageOpenedApp ${message.notification.title}");
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null) {
        // Navigator.pushNamed(context, Routes.test);
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(channel.id, channel.name,
                  importance: Importance.high,
                  channelDescription: channel.description,
                  icon: '@mipmap/ic_launcher',
                  color: AppColors.primaryColor),
            ));
      }
    });

    FirebaseMessaging.onBackgroundMessage((message) {
      Log.i("onBackgroundMessage ${message?.data}");
    });

    // print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
    // FirebaseFirestore.instance.collection('Notification').get().then((querySnapshot) {
    //   for (var element in querySnapshot.docs) {
    //     Map<String, dynamic> dataMap = element.data();
    //     print("dataMap $dataMap");
    //   }
    // });

    // CollectionReference<Map<String, dynamic>> collection =
    //     FirebaseFirestore.instance.collection("Notification");
    // print("collection.path ${collection.path}");
    // print("collection.id ${collection.id}");
    // collection.add({"test": "aaaaaaa"});
    // rootBundle.load('assets/images/background.jpg').then((byteData) {
    //   return byteData.buffer.asUint8List();
    // }).then((value) {
    //   return collection.doc("test").set({"img_background": Blob(value)});
    // }).then((value) => print("finish")).catchError((error) => print("error: $error"));
  }

  ///Don't use BlocListener, bloc is disposed when navigator to other page,
  ///so that, user stream instead
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocBuilder<MainBloc, MainState>(
        bloc: bloc,
        builder: (context, state) {
          return Scaffold(
            body: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                bloc.add(SwitchingPageEvent(pageIndex: index));
              },
              children: <Widget>[
                PostPage(GetIt.I.get<PostBloc>()),
                NewsPage(GetIt.I.get<NewsBloc>()),
                StorePage(GetIt.I.get<StoreMainBloc>()),
                POIPage(GetIt.I.get<POIBloc>()),
                ProfilePage(
                    GetIt.I.get<ProfileBloc>())
              ],
            ),
            bottomNavigationBar: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              notchMargin: 8,
              child: SizedBox(
                height: 55,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: ComponentButton(
                        index: 0,
                        label: "Cộng đồng",
                        onPressed: () {
                          _pageController.jumpToPage(0);
                        },
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: ComponentButton(
                        index: 1,
                        label: "Tin Tức",
                        onPressed: () {
                          _pageController.jumpToPage(1);
                        },
                      ),
                    ),
                    Container(
                      width: 72,
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "Cửa hàng",
                        style: TextStyle(
                            color: state.currentPageIndex == 2
                                ? AppColors.primaryColor
                                : Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      )),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: ComponentButton(
                        index: 3,
                        label: "Điểm đến",
                        onPressed: () {
                          _pageController.jumpToPage(3);
                        },
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: ComponentButton(
                        index: 4,
                        label: "Cá nhân",
                        onPressed: () {
                          _pageController.jumpToPage(4);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            floatingActionButton: state.isHiddenFAB
                ? const SizedBox()
                : FloatingActionButton(
                    child: const Icon(Icons.storefront),
                    onPressed: () {
                      _pageController.jumpToPage(2);
                    },
                    backgroundColor: AppColors.primaryColor,
                    heroTag: "main_page",
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            extendBody: true,
            resizeToAvoidBottomInset: true,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _listener.cancel();
    super.dispose();
  }
}
