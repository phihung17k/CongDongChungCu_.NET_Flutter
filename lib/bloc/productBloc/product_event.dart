import 'package:congdongchungcu/models/enum.dart';
import 'package:congdongchungcu/models/product_model/get_product_model.dart';
import 'package:congdongchungcu/models/product_model/product_agrument.dart';
import 'package:congdongchungcu/models/storedto_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '/models/product_model/product_model.dart';

class ProductEvent{}

class LoadProductByStorePageEvent extends ProductEvent{
     GetProductModel request;

     LoadProductByStorePageEvent({this.request});

}

class LoadProductGeneralPageEvent extends ProductEvent
{

}

class LoadProductGeneralPageHasCategoryIdEvent extends ProductEvent
{
     final GetProductModel model;

     LoadProductGeneralPageHasCategoryIdEvent(this.model);
}

class IncrementalProductEvent extends ProductEvent
{}

class RefreshProductEvent extends ProductEvent
{}

class LoadingEvent extends ProductEvent{}



class SelectingProductEvent extends ProductEvent
{
     final ProductAgrument productIsChoose;

     SelectingProductEvent({this.productIsChoose});
}


// event pass data store id cho category page
class PassStoreIdToAddNewProductEvent extends ProductEvent{
     //
     final ProductAgrument storeId;
     //
     PassStoreIdToAddNewProductEvent({this.storeId});
}

//navigate to product detail page
class NavigatorToDetailPage extends ProductEvent
{
     //
     final ProductModel model;

     NavigatorToDetailPage(this.model);
//

}

//Nhận productModel để
class RecieveDataEvent extends ProductEvent
{
     final ProductModel dto;

     RecieveDataEvent(this.dto);

}

//navigator to Store Page detail
class NavigatorToStoreDetailEvent extends ProductEvent
{
     final int storeId;

     NavigatorToStoreDetailEvent(this.storeId);
}

//
class SearchTopProductEvent extends ProductEvent
{
     final GetProductModel request;

     SearchTopProductEvent(this.request);
}

