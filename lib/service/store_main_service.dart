import 'package:congdongchungcu/models/category_model/category_result.dart';
import 'package:congdongchungcu/models/category_model/get_category_model.dart';
import 'package:congdongchungcu/models/paging_result_model.dart';
import 'package:congdongchungcu/models/product_model/get_product_model.dart';
import 'package:congdongchungcu/models/product_model/product_model.dart';
import 'package:congdongchungcu/service/interface/i_services.dart';
import 'package:congdongchungcu/service/service_adapter.dart';
import 'package:http/http.dart' as http;

import '../api.dart';

class StoreMainService implements IStoreMainService {
  final ServiceAdapter adapter = ServiceAdapter();

  @override
  Future<CategoryResult> getCategoriesOfStore(GetCategoryModel request) async {
    var client = http.Client();
    String url = Api.getURL(apiPath: Api.category);

    if (request.storeId != null) {
      //url
      url += "?store-id=" + request.storeId.toString();
    }
    //
    print(url);
    //
    try {
      var response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // [items] = list<Map<key,value>
        Map<String, dynamic> json = adapter.parseToMap(response);
        //
        CategoryResult result = CategoryResult.fromJson(json);
        //
        print(result.listCate[0].name);
        return result;
      }
    } finally {
      client.close();
    }
    return null;
  }

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
        if(request.categoryId == 0)
          {
            url += "&category-id=";
          }
        if(request.categoryId != 0) {
          url += "&category-id=" + request.categoryId.toString();
        }
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
        //categoryId
        if (request.categoryId != null) {
          if(request.categoryId == 0)
          {
            url += "&category-id=";
          }
          if(request.categoryId != 0) {
            url += "&category-id=" + request.categoryId.toString();
          }
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
}
