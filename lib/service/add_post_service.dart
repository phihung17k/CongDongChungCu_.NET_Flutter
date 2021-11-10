import 'dart:convert';
import 'dart:io';

import 'package:congdongchungcu/repository/user_repository.dart';
import 'package:congdongchungcu/service/interface/i_add_post_service.dart';
import 'package:congdongchungcu/service/service_adapter.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../api.dart';

class AddPostService extends IAddPostService {
  @override
  Future<int> addPost(String title, String content) async {
    ServiceAdapter adapter = ServiceAdapter();
    var client = http.Client();
    String url = Api.getURL(apiPath: Api.posts);
    String token = GetIt.I
        .get<UserRepository>()
        .selectedResident
        .authToken;
    bool result = false;
    int responeID = -1;
    try {
      var response = await client.post(Uri.parse(url),
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            "title": title,
            "content": content,
            "resident_id": GetIt.I
                .get<UserRepository>()
                .selectedResident.id,
          }));
      print("statusCode: ${response.statusCode}");
      if (response.statusCode == 201) {
        print("Create thanh cong");
        Map<String, dynamic> responeResult = adapter.parseToMap(response);
        responeID =  responeResult['id'];
      }
    } catch (e) {} finally {
      client.close();
    }
    return responeID;
  }
}