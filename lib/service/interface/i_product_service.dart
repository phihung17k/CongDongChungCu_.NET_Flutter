import 'package:congdongchungcu/models/enum.dart';
import 'package:congdongchungcu/models/paging_result_model.dart';
import 'package:congdongchungcu/models/product_model/get_product_model.dart';
import '/models/product_model/result_product_model.dart';
import '../../models/product_model/product_model.dart';

abstract class IProductService{
  //get Product by productId
  Future<PagingResult<ProductModel>> getProductByGeneral(GetProductModel request);


  //create Product
  //bên api trả ra Productmodel
  Future<ProductModel> addProduct(ProductModel model);

  //update Product
  Future<bool> updateProduct(ProductModel model);

  //delete product
  //nhớ gọi put kh gọi hàm delete
  Future<bool> deleteProduct(ProductModel model);


}