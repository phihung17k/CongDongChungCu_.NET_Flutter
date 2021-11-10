
import 'package:congdongchungcu/models/category_model/category_model.dart';
import 'package:congdongchungcu/models/product_model/get_product_model.dart';

class StoreMainEvent{}

class LoadCategoryDefaultEvent extends StoreMainEvent {}

class LoadProductGeneralPageGeneralEvent extends StoreMainEvent{}

class SelectCategoryEvent extends StoreMainEvent
{
  final CategoryModel categoryModelIsChoose;

  SelectCategoryEvent({this.categoryModelIsChoose});
}

class SearchTopProductGeneralEvent extends StoreMainEvent
{
  final GetProductModel request;

  SearchTopProductGeneralEvent(this.request);
}
