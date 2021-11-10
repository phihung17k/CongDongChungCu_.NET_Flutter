import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../models/news/news_model.dart';
import 'interface/i_services.dart';
import 'service_adapter.dart';

import '../api.dart';
import '../log.dart';

class EditNewsService extends IEditNewsService {
  ServiceAdapter adapter = ServiceAdapter();

  @override
  Future<bool> updateNews(NewsModel model, String authToken) async{
    var client = http.Client();
      String url = Api.getURL(apiPath: Api.news) + "/${model.id}";
      try {
        var response = await client.put(Uri.parse(url),
            headers: { HttpHeaders.authorizationHeader: "Bearer $authToken",
              'Content-Type': 'application/json; charset=UTF-8'},
            body: jsonEncode(<String, dynamic>{
              "title": model.title,
              "content": model.content,
              "status": true
            }));
        if (response.statusCode == 200) {
          print('success');
          return true;
        } else {
          print(response.statusCode);
          print(authToken);
          print(url);
        }
      } catch (e) {
        Log.e(e);
      } finally {
        client.close();
      }
      return false;
  }


  // @override
  // Future<bool> deleteNews(int id, String authToken) async{
  //   var client = http.Client();
  //   String url = Api.getURL(apiPath: Api.news) + "/" + id.toString();
  //   try {
  //     var response = await client.put(Uri.parse(url),
  //         headers: { HttpHeaders.authorizationHeader: "Bearer $authToken"},
  //         body: jsonEncode(<String, bool>{
  //           'status': false,
  //         }));
  //     if (response.statusCode == 200) {
  //
  //     }
  //   } catch (e) {
  //     Log.e(e);
  //   } finally {
  //     client.close();
  //   }
  //   return false;
  // }
}
