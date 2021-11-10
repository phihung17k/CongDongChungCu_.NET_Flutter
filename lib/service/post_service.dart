import 'dart:convert';
import 'dart:io';

import 'package:congdongchungcu/models/enum.dart';
import 'package:congdongchungcu/models/paging_result_model.dart';
import 'package:congdongchungcu/models/posts/get_posts_model.dart';
import 'package:congdongchungcu/models/posts/post_model.dart';
import 'package:congdongchungcu/models/resident_model.dart';
import 'package:congdongchungcu/models/user_model.dart';
import 'package:congdongchungcu/repository/user_repository.dart';
import 'package:get_it/get_it.dart';

import '../log.dart';
import './service_adapter.dart';
import 'package:http/http.dart' as http;
import '../api.dart';
import 'interface/i_services.dart';

class PostService implements IPostService {
  ServiceAdapter adapter = ServiceAdapter();

  @override
  Future<PagingResult<PostModel>> getPosts(int currentPage) async {
    var client = http.Client();
    String url = Api.getURL(apiPath: Api.posts);
    PagingResult<PostModel> pagingResult;
    // if (model.apartmentId != null) {
    //   url += "?apartment-id=" + model.apartmentId.toString();
    //   if (model.title != null) {
    //     url += "?title=" + model.title;
    //   }
    //   if (model.status.toString() != null) {
    //     url += "&status=" + model.status.index.toString();
    //   }
    // } else {
    //   url += "?status=" + model.status.index.toString();
    // }
    // if (currentPage == null) currentPage = 1;
    int apartmentId =
        GetIt.I.get<UserRepository>().selectedResident.apartmentId;
    int statusCode = Status.Approved.index;
    try {
      var response = await client.get(
          Uri.parse("$url?status=$statusCode&current-page=$currentPage"),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            "Security-Data": jsonEncode({"apartmentId": apartmentId})
          });
      if (response.statusCode == 200) {

        Map<String, dynamic> pagingMap = adapter.parseToMap(response);
        pagingResult =
            PagingResult.fromJson(pagingMap, PostModel.fromJsonModel);
        print("In ra ne");
        print("UrlIf: ${"$url?status=$statusCode&current-page=$currentPage"}");
      } else {
        print("Url: ${"$url?status=$statusCode&current-page=$currentPage"}");
      }
    } finally {
      client.close();
    }
    return pagingResult;
  }

  @override
  Future<int> getUserId(int residentId) async{
    var client = http.Client();
    String url = Api.getURL(apiPath: Api.residents);
    int userId;
    try {
      var response = await client.get(Uri.parse("$url/$residentId"));
      if (response.statusCode == 200) {
        adapter.parseToMap(response);
        String securityData = response.headers['security-data'];
        Map<String, dynamic> securityMap = jsonDecode(securityData);
        userId = securityMap['UserId'];
      }
    } catch (e) {
      Log.e(e?.message);
    } finally {
      client.close();
    }
    return userId;
  }

  @override
  Future<UserModel> getUser(int userId) async{
    var client = http.Client();
    String url = Api.getURL(apiPath: Api.users);
    UserModel user;
    try {
      var response = await client.get(Uri.parse("$url/$userId"));
      if (response.statusCode == 200) {
        Map<String, dynamic> dataMap = adapter.parseToMap(response);
        user = UserModel.fromJson(dataMap);
      }
    } catch (e) {
      Log.e(e?.message);
    } finally {
      client.close();
    }
    return user;
  }

  @override
  Future<bool> deletePost(PostModel deletePost) async {
    var client = http.Client();
    String url = Api.getURL(apiPath: Api.posts);
    String token = GetIt.I.get<UserRepository>().selectedResident.authToken;
    bool result = false;
    try {
      var response = await client.put(Uri.parse(url+"/${deletePost.id}"),
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(<String, dynamic>{
            "title": deletePost.title,
            "content": deletePost.content,
            "status": deletePost.status.index,
          }));
      print("${url+"/${deletePost.id}"}");
      print("statusCode: ${response.statusCode}");
      print("status: ${deletePost.status.index}");
      if (response.statusCode == 200) {
        print("delete thanh công");
        result = true;
      }
    } catch (e) {
    } finally {
      client.close();
    }
    return result;
  }
}
