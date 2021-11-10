

import 'package:congdongchungcu/service/add_post_service.dart';
import 'package:congdongchungcu/service/comment_service.dart';
import 'package:congdongchungcu/service/edit_comment_service.dart';
import 'package:congdongchungcu/service/edit_post_service.dart';
import 'package:congdongchungcu/service/interface/i_add_post_service.dart';
import 'package:congdongchungcu/service/interface/i_comment_service.dart';

import 'package:congdongchungcu/service/edit_poi_service.dart';

import 'package:congdongchungcu/service/interface/i_edit_comment_service.dart';
import 'package:congdongchungcu/service/interface/i_edit_poi_service.dart';
import 'package:congdongchungcu/service/interface/i_edit_post_service.dart';


import 'package:congdongchungcu/service/interface/i_add_poi_service.dart';

import 'package:congdongchungcu/service/interface/i_poi_manage_service.dart';

import 'package:congdongchungcu/service/interface/i_poi_service.dart';
import 'package:congdongchungcu/service/interface/i_post_manage_service.dart';
import 'package:congdongchungcu/service/interface/i_edit_profile_service.dart';
import 'package:congdongchungcu/service/interface/i_profile_service.dart';
import 'package:congdongchungcu/service/poi_service.dart';

import 'package:congdongchungcu/service/post_manage_service.dart';
import 'package:congdongchungcu/service/edit_profile_service.dart';
import 'package:congdongchungcu/service/profile_service.dart';

import 'package:congdongchungcu/service/register_service.dart';
import 'package:congdongchungcu/service/services.dart';



import 'package:congdongchungcu/service/splash_service.dart';
import 'package:congdongchungcu/service/store_main_service.dart';

import '../service/services.dart';
import 'package:get_it/get_it.dart';

class ServiceDependencies{
  static Future setup(GetIt injector) async {
    injector.registerFactory<ILoginService>(() => LoginService());
    injector.registerFactory<IProfileService>(() => ProfileService());
    injector.registerFactory<IEditProfileService>(() => EditProfileService());
    injector.registerFactory<IProfileSelectionService>(() => ProfileSelectionService());
    injector.registerFactory<IBuildingService>(() => BuildingService());
    injector.registerFactory<ISplashService>(() => SplashService());
    //anhntse140215
    //product
    injector.registerFactory<IProductService>(() => ProductService());
    //store
    injector.registerFactory<IStoreService>(() => StoreService());
    //category
    injector.registerFactory<ICategoryService>(() => CategoryService());

    injector.registerFactory<IStoreMainService>(() => StoreMainService());


    injector.registerFactory<IPoiService>(() => POIService());
    injector.registerFactory<IEditPoiService>(() => EditPoiService());
    injector.registerFactory<IPoiManageService>(() => POIMangeService());
    injector.registerFactory<IAddPOIService>(() => AddPOIService());
    injector.registerFactory<IResidentDialogService>(() => ResidentDialogService());

    injector.registerFactory<INewsManageService>(() => NewsManageService());
    injector.registerFactory<IEditNewsService>(() => EditNewsService());
    injector.registerFactory<ICreateNewsService>(() => CreateNewsService());
    injector.registerFactory<IPostService>(() => PostService());
    injector.registerFactory<IAddPostService>(() => AddPostService());
    injector.registerFactory<IEditPostService>(() => EditPostService());
    injector.registerFactory<ICommentService>(() => CommentService());
    injector.registerFactory<IEditCommentService>(() => EditCommentService());


    injector.registerFactory<IPostManageService>(() => PostManageService());

    injector.registerFactory<IRegisterService>(() => RegisterService());

    injector.registerFactory<INewsService>(() => NewsService());

  }
}