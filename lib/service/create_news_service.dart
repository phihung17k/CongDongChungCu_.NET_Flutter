import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../models/news/news_model.dart';
import 'interface/i_services.dart';
import 'service_adapter.dart';

import '../api.dart';
import '../log.dart';

class CreateNewsService extends ICreateNewsService {
  ServiceAdapter adapter = ServiceAdapter();

  @override
  Future<bool> createNews(NewsModel model, String authToken, int apartmentId) async{
    var client = http.Client();
    String url = Api.getURL(apiPath: Api.news);
    try {
      var response = await client.post(Uri.parse(url),
          headers: { HttpHeaders.authorizationHeader: "Bearer $authToken",
            'Content-Type': 'application/json; charset=UTF-8',
            "Security-Data": jsonEncode({"apartmentId": apartmentId})},
          body: jsonEncode(<String, dynamic>{
            "title": model.title,
            "content": model.content,
          }));
      if (response.statusCode == 201) {
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

}
