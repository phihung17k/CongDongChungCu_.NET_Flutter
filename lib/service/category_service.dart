import 'dart:convert';

import '/models/category_model/get_category_model.dart';
import '/service/service_adapter.dart';

import '../api.dart';
import '/models/category_model/category_result.dart';
import '/service/interface/i_category_service.dart';
import 'package:http/http.dart' as http;

class CategoryService implements ICategoryService
{
  //
  ServiceAdapter adapter = ServiceAdapter();

  @override
  Future<CategoryResult>  getCategoriesOfStore(GetCategoryModel request) async{
    var client = http.Client();
    String url = Api.getURL(apiPath: Api.category);
    //

    if(request.storeId != null) {
      //url
      url += "?store-id=" + request.storeId.toString();
    }
    //
    print(url);
    //
    try {
      var response = await client.get(Uri.parse(url)
      );
      if (response.statusCode == 200) {
        // [items] = list<Map<key,value>
        Map<String, dynamic> json = adapter.parseToMap(response);
        //
       CategoryResult result = CategoryResult.fromJson(json);
       //
        //print(result.listCate[0].name);
        return result;
      }
    } finally {
      client.close();
    }
    return null;
  }

  }
