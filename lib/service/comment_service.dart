import 'dart:convert';
import 'dart:io';

import 'package:congdongchungcu/models/comment/comment_model.dart';
import 'package:congdongchungcu/models/comment/get_comments_model.dart';
import 'package:congdongchungcu/models/paging_result_model.dart';
import 'package:congdongchungcu/models/user_model.dart';
import 'package:congdongchungcu/repository/user_repository.dart';
import 'package:congdongchungcu/service/interface/i_comment_service.dart';
import 'package:get_it/get_it.dart';

import '../log.dart';
import './service_adapter.dart';
import 'package:http/http.dart' as http;
import '../api.dart';
import 'interface/i_services.dart';

class CommentService implements ICommentService {
  ServiceAdapter adapter = ServiceAdapter();

  @override
  Future<PagingResult<CommentModel>> getComments(int postId, int currentPage) async {
    var client = http.Client();
    String url = Api.getURL(apiPath: Api.comments);
    PagingResult<CommentModel> pagingResult;
    // if (model.postId != null) {
    //   url += "?post-id=" + model.postId.toString();
    // }
    // print(url);
    try {
      var response = await client.get(Uri.parse("$url?post-id=$postId&current-page=$currentPage"));
      if (response.statusCode == 200) {
        Map<String, dynamic> pagingMap = adapter.parseToMap(response);
        pagingResult =
            PagingResult.fromJson(pagingMap, CommentModel.fromJsonModel);
        // return pagingResult;
        print("checkUrl200: ${"$url?post-id=$postId?current-page=$currentPage"}");
      } else {
        print("checkUrl: ${"$url?post-id=$postId?current-page=$currentPage"}");
      }
    } finally {
      client.close();
    }
    return pagingResult;
  }

  @override
  Future<bool> addComment(String content, int postId) async {
    ServiceAdapter adapter = ServiceAdapter();
    var client = http.Client();
    String url = Api.getURL(apiPath: Api.comments);
    String token = GetIt.I
        .get<UserRepository>()
        .selectedResident
        .authToken;
    bool result = false;
    try {
      var response = await client.post(Uri.parse(url),
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            "content": content,
            "post_id": postId,
            "resident_id": GetIt.I
                .get<UserRepository>()
                .selectedResident.id,

          }));
      print("contentSer: ${content}");
      print("statusCodeComment: ${response.statusCode}");
      if (response.statusCode == 201) {
        print("Create thanh cong");
        result = true;
      }
    } catch (e) {} finally {
      client.close();
    }
    return result;
  }

  @override
  Future<bool> deleteComment(int commentId, int ownerCommentId) async {
    var client = http.Client();
    String url = Api.getURL(apiPath: Api.comments);
    String token = GetIt.I.get<UserRepository>().selectedResident.authToken;
    bool result = false;
    try {
      var response = await client.delete(Uri.parse("$url?CommentId=$commentId&OwnerCommentId=$ownerCommentId"),
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
            'Content-Type': 'application/json; charset=UTF-8'
          },
          // body: jsonEncode(<String, dynamic>{
          //   // "title": deletePost.title,
          //   // "content": deletePost.content,
          //   // "status": deletePost.status.index,
          // })
      );
      print("statusCodeDeCom: ${response.statusCode}");
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
}
