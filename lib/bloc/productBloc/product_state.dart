import 'package:congdongchungcu/models/enum.dart';
import 'package:congdongchungcu/models/product_model/get_product_model.dart';
import 'package:image_picker/image_picker.dart';

import '/models/product_model/product_model.dart';
import 'package:equatable/equatable.dart';

class ProductState extends Equatable {
  final List<ProductModel> currentlistProduct;
  final GetProductModel getProductModel;
  final bool hasNext;

  //load more
  final int curpage;
  final int storeId;
  final int categoryId;
  final Status status;
  final bool isChanged;

  //product choose to edit
  final ProductModel productIsChoose;

  const ProductState(
      {this.currentlistProduct,
      this.getProductModel,
      this.hasNext,
      this.productIsChoose,
      this.categoryId,
      this.storeId,
      this.curpage,
      this.status,
      this.isChanged});

  //set lại giá trị mới
  //thông qua hàm này mình có thể cho state mới vào
  ProductState copyWith(
      {List<ProductModel> list,
      GetProductModel getProductModel,
      bool hasNext,
      bool isLoading,
      ProductModel productIsChoose,
      int categoryId,
      int storeId,
      int curpage,
      Status status,
      bool isChanged}) {
    return ProductState(
      currentlistProduct: list ?? this.currentlistProduct,
      getProductModel: getProductModel ?? this.getProductModel,
      hasNext: hasNext ?? this.hasNext,
      productIsChoose: productIsChoose ?? this.productIsChoose,
      categoryId: categoryId ?? this.categoryId,
      storeId: storeId ?? this.storeId,
      curpage: curpage ?? this.curpage,
      status: status ?? this.status,
      isChanged: isChanged ?? this.isChanged,
    );
  }

  //cái này quá là lợi hại luôn
  @override
  // TODO: implement props
  List<Object> get props => [
        currentlistProduct,
        getProductModel,
        hasNext,
        productIsChoose,
        categoryId,
        storeId,
        curpage,
        status,
        isChanged,
      ];
}
