import 'package:congdongchungcu/models/category_model/category_model.dart';
import 'package:congdongchungcu/models/category_model/get_category_model.dart';
import 'package:congdongchungcu/models/product_model/product_model.dart';

class CategoryEvent{}

class LoadCategoryEvent extends CategoryEvent{
 final GetCategoryModel getCategoryModel;
 final CategoryModel categoryModel;
 LoadCategoryEvent({this.getCategoryModel,this.categoryModel});
}


class LoadCategoryDefault extends CategoryEvent {}

class SelectCategoryEvent extends CategoryEvent
{
  final CategoryModel categoryModelIsChoose;

  SelectCategoryEvent({this.categoryModelIsChoose});
}

//này để chuyển categoryModel sang BlocProduct
class PassDataCategoryIsChooseEvent extends CategoryEvent
{

 //category đc chọn
 final CategoryModel categoryModel;

 PassDataCategoryIsChooseEvent({this.categoryModel});
}

class PassDataCategoryEvent extends CategoryEvent
{

  //list category để gửi qua cho trang product
  final List<CategoryModel> listCategory;

  PassDataCategoryEvent({this.listCategory});
}


//nhận data store id từ ProductPage
class RecieveDataFromProductPageEvent extends CategoryEvent
{
  final int storeId;
  //
  RecieveDataFromProductPageEvent({this.storeId});
  //

}


// class DefaultValueOfDropdown extends CategoryEvent
// {
//   final CategoryModel categoryModel;
//   DefaultValueOfDropdown({this.categoryModel});
// }