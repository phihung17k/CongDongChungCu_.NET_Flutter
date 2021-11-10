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

class NewsService extends INewsService {
  ServiceAdapter adapter = ServiceAdapter();

  @override
  Future<PagingResult<NewsModel>> getNewsByCondition(GetNewsModel model, int apartmentId) async {
    var client = http.Client();
    String url = Api.getURL(apiPath: Api.news) + "?status=true" + "&current-page=" + model.currPage.toString();
    PagingResult<NewsModel> pagingResult;
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

}
