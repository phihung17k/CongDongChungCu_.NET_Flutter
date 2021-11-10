import 'package:congdongchungcu/models/category_model/category_model.dart';
import 'package:congdongchungcu/models/product_model/get_product_model.dart';
import 'package:congdongchungcu/models/product_model/product_model.dart';
import 'package:equatable/equatable.dart';

class StoreMainState extends Equatable {
  final List<CategoryModel> listCategory;
  final List<ProductModel> listProduct;
  final CategoryModel isCategoryChoose;
  final GetProductModel getProductModel;

  const StoreMainState({
    this.listCategory,
    this.listProduct,
    this.isCategoryChoose,
    this.getProductModel,
  });

  StoreMainState copyWith({
    List<CategoryModel> listCategory,
    List<ProductModel> listProduct,
    CategoryModel isCategoryChoose,
    GetProductModel getProductModel,
  }) {
    return StoreMainState(
      listCategory: listCategory ?? this.listCategory,
      listProduct: listProduct ?? this.listProduct,
      isCategoryChoose: isCategoryChoose ?? this.isCategoryChoose,
      getProductModel: getProductModel ?? this.getProductModel,
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [
        listCategory,
        listProduct,
        isCategoryChoose,
        getProductModel,
      ];
}
