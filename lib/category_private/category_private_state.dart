import 'package:congdongchungcu/models/category_model/category_model.dart';
import 'package:congdongchungcu/models/category_model/get_category_model.dart';
import 'package:equatable/equatable.dart';

class CategoryPrivateState extends Equatable
{
  final List<CategoryModel> listCategory;
  //
  final GetCategoryModel getCategoryModel;
  //
  final CategoryModel isCategoryChoose;

  const CategoryPrivateState({this.listCategory, this.getCategoryModel, this.isCategoryChoose});

  //state
  CategoryPrivateState copyWith({List<CategoryModel>list, GetCategoryModel getCategoryModel ,CategoryModel isCategoryChoose})
  {
    return CategoryPrivateState(listCategory: list ?? this.listCategory,
        getCategoryModel: getCategoryModel ?? this.getCategoryModel,
        isCategoryChoose: isCategoryChoose ?? this.isCategoryChoose
    );
  }

  @override
  List<Object> get props => [listCategory, getCategoryModel, isCategoryChoose];

}