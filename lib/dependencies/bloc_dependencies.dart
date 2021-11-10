

import 'package:congdongchungcu/bloc/add_post/add_post_bloc.dart';
import 'package:congdongchungcu/bloc/comment/comment_bloc.dart';
import 'package:congdongchungcu/bloc/category/category_bloc.dart';
import 'package:congdongchungcu/bloc/dialog_widget/dialog_widget_bloc.dart';
import 'package:congdongchungcu/bloc/edit_comment/edit_comment_bloc.dart';
import 'package:congdongchungcu/bloc/edit_profile/edit_profile_bloc.dart';
import 'package:congdongchungcu/bloc/map/map_bloc.dart';
import 'package:congdongchungcu/bloc/map_admin/map_admin_bloc.dart';
import 'package:congdongchungcu/bloc/post_manage/post_manage_bloc.dart';

import 'package:congdongchungcu/bloc/add_poi/add_poi_bloc.dart';
import 'package:congdongchungcu/bloc/edit_product/edit_product_bloc.dart';
import 'package:congdongchungcu/bloc/edit_store_bloc/edit_store_bloc.dart';
import 'package:congdongchungcu/bloc/store_main/store_main_bloc.dart';
import 'package:congdongchungcu/category_private/category_private_bloc.dart';
import '../bloc/notification/notification_bloc.dart';
import '../bloc/news/news_bloc.dart';
import '../bloc/create_news/create_news_bloc.dart';
import 'package:congdongchungcu/bloc/profile_selection/profile_selection_bloc.dart';
import 'package:congdongchungcu/bloc/register/register_bloc.dart';

import '../bloc/edit_news/edit_news_bloc.dart';


import 'package:congdongchungcu/bloc/edit_poi/edit_poi_bloc.dart';

import 'package:congdongchungcu/bloc/edit_post/edit_post_bloc.dart';

import 'package:congdongchungcu/bloc/poi_manage/poi_manage_bloc.dart';

import 'package:congdongchungcu/bloc/profile/profile_bloc.dart';

import 'package:congdongchungcu/bloc/resident_dialog/resident_dialog_bloc.dart';
import 'package:congdongchungcu/bloc/productBloc/product_bloc.dart';
import 'package:congdongchungcu/bloc/store/store_bloc.dart';
import '../bloc/poi/poi_bloc.dart';

import '../bloc/news_manage/news_manage_bloc.dart';

import '../bloc/post/post_bloc.dart';

import '../bloc/splash/splash_bloc.dart';
import '../bloc/login/login_bloc.dart';
import '../bloc/main/main_bloc.dart';
import '../bloc/counter/counter_bloc.dart';
import 'package:get_it/get_it.dart';

class BlocDependencies {
  static Future setup(GetIt injector) async {
    injector.registerFactory<CounterBloc>(() => CounterBloc());
    injector.registerFactory<SplashBloc>(() => SplashBloc(injector()));
    injector.registerFactory<LoginBloc>(() => LoginBloc(injector()));
    injector.registerSingleton<ProfileBloc>(ProfileBloc(injector()));
    injector.registerFactory<EditProfileBloc>(() => EditProfileBloc(injector()));
    injector.registerFactory<ProfileSelectionBloc>(() => ProfileSelectionBloc(injector()));
    injector.registerFactory<MainBloc>(() => MainBloc());

    //anhntse140215
    //injector.registerFactory<ProductBloc>(() => ProductBloc(service: injector()));
    //
    //injector.registerFactory<POIBloc>(() => POIBloc(injector()));

    //injector.registerFactory<NotificationBloc>(() => NotificationBloc(injector()));
    injector.registerFactory<CommentBloc>(() => CommentBloc(injector()));
    injector.registerFactory<EditCommentBloc>(() => EditCommentBloc(injector()));
    injector.registerSingleton<PostBloc>(PostBloc(injector()));
    injector.registerFactory<AddPostBloc>(() => AddPostBloc(injector()));
   // injector.registerSingleton<EditPostBloc>(EditPostBloc(injector()));
    injector.registerFactory<EditPostBloc>(() => EditPostBloc(injector()));

    //injector.registerFactory<PostManageBloc>((PostManageBloc(injector()));
        injector.registerFactory<PostManageBloc>(() => PostManageBloc(injector()));


    //product
    //singleton để giữ state
    injector.registerFactory<ProductBloc>(() => ProductBloc(service: injector()));

    //injector.registerSingleton<ProductBloc>(ProductBloc(service: injector()));
    // injector.registerSingleton<CategoryBloc>(CategoryBloc(injector()));
    //category để giữ state
    injector.registerFactory<CategoryBloc>(() =>CategoryBloc(injector()));
    //
    injector.registerFactory<CategoryPrivateBloc>(() => CategoryPrivateBloc(injector()));
    // injector.registerSingleton<ProductGeneralBloc>(ProductGeneralBloc(service:injector()));
    injector.registerSingleton<StoreMainBloc>(StoreMainBloc(injector()));

    //

    //store
    injector.registerFactory<StoreBloc>(() =>StoreBloc(injector()));

    injector.registerFactory<EditStoreBloc>(() =>EditStoreBloc(service: injector()));
    //
    injector.registerFactory<EditProductBloc>(() => EditProductBloc(service: injector()));

    //poi
    injector.registerSingleton<POIBloc>(POIBloc(injector()));
    injector.registerFactory<EditPOIBloc>(() => EditPOIBloc(injector()));
    injector.registerFactory<POIManageBloc>(() => POIManageBloc(injector()));
    injector.registerFactory<AddPOIBloc>(() => AddPOIBloc(injector()));
    injector.registerFactory<RegisterBloc>(() => RegisterBloc(injector()));

    injector.registerFactory<ResidentDialogBloc>(() => ResidentDialogBloc(injector()));

    injector.registerFactory<NewsManageBloc>(() => NewsManageBloc(injector()));
    injector.registerFactory<EditNewsBloc>(() => EditNewsBloc(injector()));
    injector.registerFactory<CreateNewsBloc>(() => CreateNewsBloc(injector()));
    injector.registerSingleton<NewsBloc>(NewsBloc(injector()));
    injector.registerFactory<NotificationBloc>(() => NotificationBloc());

    injector.registerFactory<DialogWidgetBloc>(() => DialogWidgetBloc());
    injector.registerFactory<MapBloc>(() => MapBloc());
    injector.registerFactory<MapAdminBloc>(() => MapAdminBloc());
  }
}