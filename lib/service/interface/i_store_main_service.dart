
import 'package:congdongchungcu/models/category_model/category_result.dart';
import 'package:congdongchungcu/models/category_model/get_category_model.dart';
import 'package:congdongchungcu/models/paging_result_model.dart';
import 'package:congdongchungcu/models/product_model/get_product_model.dart';
import 'package:congdongchungcu/models/product_model/product_model.dart';

abstract class IStoreMainService{
  Future<CategoryResult> getCategoriesOfStore(GetCategoryModel request);

  Future<PagingResult<ProductModel>> getProductByGeneral(GetProductModel request);
}