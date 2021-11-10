
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class Routes {
  static String get defaultRoute => '/';
  static String get splash => '/splash';
  static String get test => '/test';
  static String get login => '/login';
  static String get main => '/main';
  static String get editProfile => '/edit_profile';
  static String get profileSelection => '/profile_selection';
  //
  static String get storeDetail => '/store_detail';
  static String get listStore => '/list_store';
  static String get editStoreInfo => '/edit_store_info';
  static String get editStore => '/edit_store';
  static String get storePersonal => '/store_personal';
  static String get addNewProduct => '/add_new_product';
  static String get productDetail => '/product_detail';
  //anhntse140215
  static String get product => '/product';
  //
  static String get category => '/category';
  //
  static String get storeActive => '/store_active';

  static String get poi => '/poi';
  static String get create_news => '/create_news';
  static String get news_manage => '/news_manage';
  static String get edit_news => '/edit_news';
  static String get post => '/post';
  static String get add_post => '/add_post';
  static String get edit_post => '/edit_post';
  static String get comment => '/comment';
  static String get edit_comment => '/edit_comment';
  static String get post_manage => '/post_manage';
  static String get edit_poi => '/edit_poi';
  static String get add_poi => 'add_poi';
  static String get poi_manage => '/poi_manage';
  static String get get_notification => '/get_notification';
  static String get register => '/register';
  static String get notification => '/notification';

  //management
  static String get listStoreManagement => '/list_store_management';
  static String get productpageManagement => '/product_page_management';
  static String get productDetailManagement => '/product_detail_management';

  static String get map => '/map';
  static String get mapAdmin => '/mapAdmin';


  static MaterialPageRoute getRoute(RouteSettings settings){
    Widget widget;
    try{
      widget = GetIt.I.get<Widget>(instanceName: settings.name);
    } catch (e) {
      widget = Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: Text("Page not found"),
        ),
      );
    }
    return MaterialPageRoute(builder: (_) => widget, settings: settings);
  }
}