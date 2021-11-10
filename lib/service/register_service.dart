import 'dart:convert';
import 'dart:io';

import 'package:congdongchungcu/models/user/register_user_model.dart';
import 'package:congdongchungcu/models/user_model.dart';
import 'package:congdongchungcu/service/interface/i_services.dart';

import '../log.dart';
import 'service_adapter.dart';
import 'package:http/http.dart' as http;
import '../api.dart';
import 'package:crypto/crypto.dart';

class RegisterService extends IRegisterService {
  ServiceAdapter adapter = ServiceAdapter();

  @override
  Future<RegisterUserModel> createUser(String password, String email) async {
    var client = http.Client();
    String url = Api.getURL(apiPath: Api.users);
    RegisterUserModel result;
    var bytes = utf8.encode(password);
    Digest sha256Password = sha256.convert(bytes);
    try {
      var response = await client.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            "username": "",
            "password": sha256Password.toString(),
            "fullname": "",
            "phone": "",
            "email": email,
            "isSystemAdmin": false,
            "status": true
          }));

      if (response.statusCode == 201) {
        Map<String, dynamic> data = adapter.parseToMap(response);
        UserModel user = UserModel.fromJson(data);
        result = RegisterUserModel(user: user, resultCode: response.statusCode);
      } else if (response.statusCode == 400) {
        result = RegisterUserModel(
            resultCode: response.statusCode, errorMessage: response.body);
      }
    } catch (e) {
      Log.e(e.toString());
    } finally {
      client.close();
    }
    return result;
  }

  @override
  Future<String> getJWTToken(String idToken) async {
    var client = http.Client();
    String url = Api.getURL(apiPath: Api.authentication);
    try {
      var response = await client.post(Uri.parse(url),
          headers: {HttpHeaders.authorizationHeader: "Bearer $idToken"});
      if (response.statusCode == 200) {
        String result = adapter.parseToString(response);
        return result;
      }
    } catch (e) {
      Log.e(e);
    } finally {
      client.close();
    }
    return null;
  }
}
