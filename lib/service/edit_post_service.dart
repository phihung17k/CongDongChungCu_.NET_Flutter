import 'dart:convert';
import 'dart:io';

import 'package:congdongchungcu/bloc/edit_poi/edit_poi_event.dart';
import 'package:congdongchungcu/models/poi/poi_model.dart';

import 'package:congdongchungcu/models/posts/post_model.dart';
import 'package:congdongchungcu/repository/user_repository.dart';
import 'package:congdongchungcu/service/interface/i_edit_post_service.dart';
import 'package:congdongchungcu/service/service_adapter.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import '../api.dart';
import '../log.dart';

class EditPostService extends IEditPostService{
  ServiceAdapter adapter = ServiceAdapter();
  @override
  Future<bool> updatePostByID(PostModel updatePost) async {
    var client = http.Client();
    String url = Api.getURL(apiPath: Api.posts);
    String token = GetIt.I
        .get<UserRepository>()
        .selectedResident
        .authToken;
    bool result = false;
    try {
      var response = await client.put(Uri.parse(url+"/${updatePost.id}"),
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(<String, dynamic>{
            "title": updatePost.title,
            "content": updatePost.content,
            "status": updatePost.status.index,
          }));
      print("${url+"/${updatePost.id}"}");
      print("statusCode: ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 404) {
        result = true;
      }
    } catch (e) {
    } finally {
      client.close();
    }
    return result;
  }
}