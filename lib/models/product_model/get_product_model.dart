//trang này hứng query mình muốn tìm
import 'package:congdongchungcu/models/enum.dart';

class GetProductModel {
  int StoreId;
  String NameOfProduct;
  String CategoryName;
  Status status;
  int PriceFrom;
  int PriceTo;
  int currPage;
  int pageSize;
  int categoryId;

  GetProductModel(
      {this.StoreId,
      this.NameOfProduct,
      this.CategoryName,
      this.status,
      this.PriceFrom,
      this.PriceTo,
      this.currPage,
      this.pageSize,
      this.categoryId});

  @override
  String toString() {
    return "$categoryId - $CategoryName - $status - $StoreId - $NameOfProduct ";
  }
}
