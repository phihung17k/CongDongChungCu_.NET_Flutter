import 'dart:convert';
import 'package:congdongchungcu/models/paging_result_model.dart';
import 'package:congdongchungcu/models/product_model/get_product_model.dart';
import '../log.dart';
import '../models/product_model/product_model.dart';
import '/service/services.dart';
import 'package:http/http.dart' as http;
import '../api.dart';
import 'service_adapter.dart';

class ProductService implements IProductService
{

  ServiceAdapter adapter = ServiceAdapter();


  //Lấy List productBloc thuộc Store Id
  @override
  Future<PagingResult<ProductModel>> getProductByGeneral(GetProductModel request) async {
     var client = http.Client();
     String url = Api.getURL(apiPath: Api.productByStoreId);
     PagingResult<ProductModel> pagingResult;
     //check request để thêm vào URL

     //store ID has value
     if(request.StoreId != null) {
       url += "?store-id=" + request.StoreId.toString();
       //Status
       //print("STATUS : "+ request.status.toString());
       if (request.status != null) {
         url += "&Status=" + request.status.index.toString();
       }
       //name product
       if (request.NameOfProduct != null) {
         url += "&name-of-product=" + request.NameOfProduct;
       }
       //category name
       if (request.CategoryName != null) {
         url += "&category-name=" + request.CategoryName;
       }
       //categoryId
       if (request.categoryId != null) {
         url += "&category-id=" + request.categoryId.toString();
       }
       //price from
       if (request.PriceFrom != null) {
         url += "&price-from=" + request.PriceFrom.toString();
       }
       //price to
       if (request.PriceTo != null) {
         url += "&price-to=" + request.PriceTo.toString();
       }
       //cur-page
       if(request.currPage != null)
         {
           url += "&current-page=" + request.currPage.toString();
         }
       //page-size
       if(request.pageSize != null)
       {
         url += "&page-size=" + request.pageSize.toString();
       }
     }
     //store ID Hasn't value
     else
       {
         print("chạy vào đây search cho tao");
         if (request.status != null) {
           url += "?Status=" + request.status.index.toString();

           if (request.NameOfProduct != null) {
             url += "&name-of-product=" + request.NameOfProduct;
           }
           if (request.categoryId != null) {
             url += "&category-id=" + request.categoryId.toString();
           }
           //cur-page
           if (request.currPage != null) {
             url += "&current-page=" + request.currPage.toString();
           }
           //page-size
           if (request.pageSize != null) {
             url += "&page-size=" + request.pageSize.toString();
           }
         }else {
           //categoryId
           // if (request.categoryId != null) {
           //   url += "?category-id=" + request.categoryId.toString();
           // }
           // //cur-page
           // if (request.currPage != null) {
           //   url += "&current-page=" + request.currPage.toString();
           // }
           // //page-size
           // if (request.pageSize != null) {
           //   url += "&page-size=" + request.pageSize.toString();
           // }
         }
       }

     print("Service gọi api: " + url);


    try {
      var response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map<String, dynamic> result = adapter.parseToMap(response);
        pagingResult = PagingResult.fromJson(result, ProductModel.fromJsonModel);
        return pagingResult;
      }
    } finally {
      client.close();
    }
    return null;
  }

  @override
  Future<ProductModel> addProduct(ProductModel model) async {
    // TODO: implement addProduct
    var client = http.Client();
    String url = Api.getURL(apiPath: Api.productByStoreId);
    ProductModel result;
    try {
      // print("Xuống service để add product");
      // print(model.name);
      // print(model.price);
      // print(model.description);
      // print(model.categoryId);
      // print(model.storeId);

      var response = await client.post(Uri.parse(url),
          headers: {
           'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(<String, dynamic>{
            "name": model.name,
            "price": model.price,
            "description": model.description,
            "category_id": model.categoryId,
            "store_id": model.storeId
          }));
      if (response.statusCode == 201) {
        print('success');
        Map<String, dynamic> mapData = adapter.parseToMap(response);
        result = ProductModel.fromJson(mapData);
      } else {
        print(response.statusCode);
        //print(authToken);
        print(url);
      }
    } catch (e) {
      Log.e(e);
    } finally {
      client.close();
    }
    return result;
  }


  @override
  Future<bool> updateProduct(ProductModel model) async {
    // TODO: implement addProduct
    //
    int id = model.id;
    print("Xuống service để update product");
    //print(model.name);
    print(model.price);
    print(model.description);
    //print(model.categoryId);
    //print(model.storeId);
    var client = http.Client();
    String url = Api.getURL(apiPath: Api.productByStoreId +"/"+ id.toString());
    try {
      var response = await client.put(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(<String, dynamic>{
            "price": model.price.toString(),
            "description": model.description,
            "status": model.status.index
          }));
      // adapter.parseToMap(response);
      if (response.statusCode == 200) {
        print('success');
        return true;
      } else {
        print(response.statusCode);
        print(url);
      }
    } catch (e) {
      Log.e(e);
    } finally {
      client.close();
    }
    return false;
  }


  @override
  Future<bool> deleteProduct(ProductModel model) async{
    // TODO: implement addProduct
    //
    int id = model.id;
    var client = http.Client();
    String url = Api.getURL(apiPath: Api.productByStoreId +"/"+ id.toString());
    try {
      var response = await client.put(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(<String, dynamic>{
            "price": model.price,
            "description": model.description,
            "status": model.status.index
          }));
      if (response.statusCode == 200) {
        print('success');
        return true;
      } else {
        print(response.statusCode);
        print(url);
      }
    } catch (e) {
      Log.e(e);
    } finally {
      client.close();
    }
    return false;
  }

  }
