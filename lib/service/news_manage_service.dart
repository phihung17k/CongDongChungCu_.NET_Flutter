import 'dart:convert';
import 'dart:io';

import '../../../models/news/get_news_model.dart';
import '../../../models/paging_result_model.dart';
import 'package:http/http.dart' as http;
import '../../../models/news/news_model.dart';
import 'service_adapter.dart';

import '../api.dart';
import '../log.dart';
import 'interface/i_services.dart';

class NewsManageService extends INewsManageService {
  ServiceAdapter adapter = ServiceAdapter();

  @override
  Future<PagingResult<NewsModel>> getNewsByCondition(GetNewsModel model, int apartmentId) async {
    var client = http.Client();
    String url = Api.getURL(apiPath: Api.news) + "?status=true" + "&current-page=" + model.currPage.toString();
    PagingResult<NewsModel> pagingResult;
    if (model.keyword != null) {
      url += "&keyword=" + model.keyword;
    }
    if (model.fromDate != null) {
      url += "&from-date=" +
          model.fromDate +
          "&to-date=" +
          model.toDate;
    }
    try {
      var response = await client.get(Uri.parse(url),
          headers: { HttpHeaders.contentTypeHeader: "application/json",
            "Security-Data": jsonEncode({"apartmentId": apartmentId})});
      Map<String, dynamic> pagingMap = adapter.parseToMap(response);
      if (response.statusCode == 200) {
        pagingResult =
            PagingResult.fromJson(pagingMap, NewsModel.fromJsonModel);
      }
    } catch (e) {
      Log.e(e);
    } finally {
      client.close();
    }
    return pagingResult;
  }

  @override
  Future<bool> deleteNews(int id, String authToken) async{
    var client = http.Client();
    String url = Api.getURL(apiPath: Api.news) + "/$id";
    try {
      var response = await client.put(Uri.parse(url),
          headers: { HttpHeaders.authorizationHeader: "Bearer $authToken",
            'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(<String, bool>{
            'status': false,
          }));
      if (response.statusCode == 200) {
        print('success');
return true;
      } else {
        print(url);
        print(response.statusCode);
        print(authToken);
      }
    } catch (e) {
      Log.e(e);
    } finally {
      client.close();
    }
    return false;
  }

@override
Future<NewsModel> getNewsById(int id) async{
  var client = http.Client();
  String url = Api.getURL(apiPath: Api.news) + "/$id";
  NewsModel news;
  try {
    var response = await client.get(Uri.parse(url));
    Map<String, dynamic> apartmentMap = adapter.parseToMap(response);
    if (response.statusCode == 200) {
      news = NewsModel.fromJson(apartmentMap);
    }
  } catch (e) {
    Log.e(e);
  } finally {
    client.close();
  }
  return news;
}

  // @override
  // Future<ApartmentModel> getApartmentById(int id) async{
  //   var client = http.Client();
  //   String url = Api.getURL(apiPath: Api.apartments) + "/" + id.toString();
  //   ApartmentModel apartment;
  //   try {
  //     var response = await client.get(Uri.parse(url));
  //     Map<String, dynamic> apartmentMap = adapter.parseToMap(response);
  //     if (response.statusCode == 200) {
  //       apartment = ApartmentModel.fromJson(apartmentMap);
  //     }
  //   } catch (e) {
  //     Log.e(e);
  //   } finally {
  //     client.close();
  //   }
  //   return apartment;
  // }
}
