import 'package:congdongchungcu/models/category_model/category_model.dart';
import 'package:congdongchungcu/models/category_model/get_category_model.dart';
import 'package:equatable/equatable.dart';

class CategoryState extends Equatable
{
  final List<CategoryModel> listCategory;
  //
  final GetCategoryModel getCategoryModel;
  //
  final CategoryModel isCategoryChoose;

  const CategoryState({this.listCategory, this.getCategoryModel, this.isCategoryChoose});

  //state
  CategoryState copyWith({List<CategoryModel>list, GetCategoryModel getCategoryModel ,CategoryModel isCategoryChoose})
  {
    return CategoryState(listCategory: list ?? this.listCategory,
    getCategoryModel: getCategoryModel ?? this.getCategoryModel,
    isCategoryChoose: isCategoryChoose ?? this.isCategoryChoose
    );
  }

  @override
  List<Object> get props => [listCategory, getCategoryModel, isCategoryChoose];

}