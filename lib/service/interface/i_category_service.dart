import 'package:congdongchungcu/models/category_model/get_category_model.dart';

import '/models/category_model/category_result.dart';

abstract class ICategoryService{
  Future<CategoryResult> getCategoriesOfStore(GetCategoryModel request);
}