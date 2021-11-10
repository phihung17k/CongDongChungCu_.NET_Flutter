import 'package:congdongchungcu/models/product_model/product_model.dart';
import 'package:congdongchungcu/page/add_post/add_new_post.dart';
import 'package:congdongchungcu/page/edit_comment/edit_comment.dart';
import 'package:congdongchungcu/page/edit_post/edit_post.dart';
import 'package:congdongchungcu/page/map/map_page.dart';
import 'package:congdongchungcu/page/map_admin/map_admin_page.dart';
import 'package:congdongchungcu/page/post_manage/manage_post_page.dart';
import 'package:congdongchungcu/page/product/widgets/gridview_product_by_category.dart';
import 'package:congdongchungcu/page/store_personal/store_personal.dart';
import 'package:congdongchungcu/page/post/post_page.dart';
import 'package:congdongchungcu/bloc/register/register_bloc.dart';
import 'package:congdongchungcu/page/add_poi_page/add_poi_page.dart';
import 'package:congdongchungcu/page/poi_manage_page/poi_manage_page.dart';
import 'package:congdongchungcu/page/register/register_page.dart';
import 'package:congdongchungcu/page/store_personal/store_personal.dart';
import 'package:congdongchungcu/page/post/post_page.dart';

import '../page/pages.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../router.dart';

class PageDependencies {
  static Future setup(GetIt injector) async{

    injector.registerFactory<Widget>(() => TestPage(injector()), instanceName: Routes.test);
    injector.registerFactory<Widget>(() => SplashPage(injector()), instanceName: Routes.splash);
    injector.registerFactory<Widget>(() => LoginPage(injector()), instanceName: Routes.login);
    injector.registerFactory<Widget>(() => MainPage(injector()), instanceName: Routes.main);
    injector.registerFactory<Widget>(() => EditProfile(injector(), injector()), instanceName: Routes.editProfile);
    injector.registerFactory<Widget>(() => ProfileSelectionPage(injector()), instanceName: Routes.profileSelection);

    injector.registerFactory<Widget>(() => NewsManagePage(injector()), instanceName: Routes.news_manage);
    injector.registerFactory<Widget>(() => EditNewsPage(injector()), instanceName: Routes.edit_news);
    injector.registerFactory<Widget>(() => CreateNewsPage(injector()), instanceName: Routes.create_news);
    //anhntse140215
    injector.registerFactory<Widget>(() => ProductPage(Productbloc: injector(),categoryPrivateBloc: injector(), ), instanceName: Routes.product);
    injector.registerFactory<Widget>(() => EditStoreInfo(editStoreBloc: injector()), instanceName: Routes.editStore);
    injector.registerFactory<Widget>(() => StoreDetail(injector()), instanceName: Routes.storeDetail);
    // injector.registerFactory<Widget>(() => ListStore(), instanceName: Routes.listStore);
    injector.registerFactory<Widget>(() => StoreActivePage(editStoreBloc: injector()), instanceName: Routes.storeActive);
    injector.registerFactory<Widget>(() => ListStorePage(storeBloc: injector()), instanceName: Routes.listStore);
    injector.registerFactory<Widget>(() => CategoryPage(Categorybloc: injector(),), instanceName: Routes.category);
    injector.registerFactory<Widget>(() => StorePersonal(storeBloc: injector(),productBloc: injector(),categoryPrivateBloc: injector(),), instanceName: Routes.storePersonal);
    injector.registerFactory<Widget>(() => AddNewProduct(editProductBloc: injector(),categoryBloc: injector(),), instanceName: Routes.addNewProduct);
    injector.registerFactory<Widget>(() => ProductDetail(productBloc: injector()), instanceName: Routes.productDetail);
    //management
    injector.registerFactory<Widget>(() => ListStoreManagement(storeBloc: injector()), instanceName: Routes.listStoreManagement);
    injector.registerFactory<Widget>(() => ProductPageManagement(Productbloc: injector(),categoryPrivateBloc: injector(),), instanceName: Routes.productpageManagement);
    injector.registerFactory<Widget>(() => ProductDetailMangement(productBloc: injector(), editProductBloc: injector(),), instanceName: Routes.productDetailManagement);




    //injector.registerFactory<Widget>(() => ProductPage(injector()), instanceName: Routes.product);



    injector.registerFactory<Widget>(() => POIManagePage(injector()), instanceName: Routes.poi_manage);

    injector.registerFactory<Widget>(() => PostPage(injector()), instanceName: Routes.post);
    injector.registerFactory<Widget>(() => AddPostPage(injector()), instanceName: Routes.add_post);
    injector.registerFactory<Widget>(() => EditPostPage(injector()), instanceName: Routes.edit_post);

    injector.registerFactory<Widget>(() => CommentPage(injector()), instanceName: Routes.comment);
    injector.registerFactory<Widget>(() => EditCommentPage(injector()), instanceName: Routes.edit_comment);


    injector.registerFactory<Widget>(() => PostManagePage(injector()), instanceName: Routes.post_manage);

    injector.registerFactory<Widget>(() => EditPoiPage(injector()), instanceName: Routes.edit_poi);

    injector.registerFactory<Widget>(() => AddPOIPage(injector()), instanceName: Routes.add_poi);
  
    injector.registerFactory<Widget>(() => RegisterPage(injector()), instanceName: Routes.register);

    injector.registerFactory<Widget>(() => NotificationPage(injector()), instanceName: Routes.notification);
    injector.registerFactory<Widget>(() => MapPage(injector()), instanceName: Routes.map);
    injector.registerFactory<Widget>(() => MapAdminPage(injector()), instanceName: Routes.mapAdmin);
  }
}
