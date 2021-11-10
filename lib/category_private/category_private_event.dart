import 'package:congdongchungcu/models/category_model/category_model.dart';
import 'package:congdongchungcu/models/category_model/get_category_model.dart';
import 'package:congdongchungcu/models/product_model/product_model.dart';

class CategoryPrivateEvent{}

class LoadCategoryPrivateEvent extends CategoryPrivateEvent{
  final GetCategoryModel getCategoryModel;
  final CategoryModel categoryModel;
  LoadCategoryPrivateEvent({this.getCategoryModel,this.categoryModel});
}


class LoadCategoryPrivateDefault extends CategoryPrivateEvent {}

class SelectCategoryPrivateEvent extends CategoryPrivateEvent
{
  final CategoryModel categoryModelIsChoose;

  SelectCategoryPrivateEvent({this.categoryModelIsChoose});

}

//này để chuyển categoryModel sang BlocProduct
class PassDataCategoryPrivateIsChooseEvent extends CategoryPrivateEvent
{

  //category đc chọn
  final CategoryModel categoryModel;

  PassDataCategoryPrivateIsChooseEvent({this.categoryModel});
}

// class PassDataCategoryPrivateEvent extends CategoryPrivateEvent
// {
//
//   //list category để gửi qua cho trang product
//   final List<CategoryModel> listCategory;
//
//   PassDataCategoryPrivateEvent({this.listCategory});
// }
//
//
// //nhận data store id từ ProductPage
// class RecieveDataCategoryPrivateFromProductPageEvent extends CategoryPrivateEvent
// {
//   final int storeId;
//   //
//   RecieveDataCategoryPrivateFromProductPageEvent({this.storeId});
// //
//
// }


// class DefaultValueOfDropdown extends CategoryEvent
// {
//   final CategoryModel categoryModel;
//   DefaultValueOfDropdown({this.categoryModel});
// }