import 'dart:convert';
import 'dart:io';

import 'package:congdongchungcu/models/comment/comment_model.dart';
import 'package:congdongchungcu/models/posts/post_model.dart';
import 'package:congdongchungcu/repository/user_repository.dart';
import 'package:congdongchungcu/service/interface/i_edit_comment_service.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import '../api.dart';
import 'service_adapter.dart';

class EditCommentService extends IEditCommentService {
  ServiceAdapter adapter = ServiceAdapter();

  @override
  Future<bool> updateCommentByID(CommentModel commentUpdate) async {
    var client = http.Client();
    String url = Api.getURL(apiPath: Api.comments);
    String token = GetIt.I.get<UserRepository>().selectedResident.authToken;
    bool result = false;
    try {
      var response =
          await client.put(Uri.parse(url + "/${commentUpdate.commentId}"),
              headers: {
                HttpHeaders.authorizationHeader: "Bearer $token",
                'Content-Type': 'application/json; charset=UTF-8'
              },
              body: jsonEncode(<String, dynamic>{
                "content": commentUpdate.content,
                "owner_comment_id": commentUpdate.residentId,
              }));
      print("${url + "/${commentUpdate.commentId}"}");
      print("statusCode: ${response.statusCode}");
      print("conetn: ${commentUpdate.content}");
      print("reId: ${commentUpdate.residentId}");
      if (response.statusCode == 200) {
        result = true;
      }
    } catch (e) {
    } finally {
      client.close();
    }
    return result;
  }
}
