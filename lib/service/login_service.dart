import 'dart:convert';
import 'dart:io';
import 'package:congdongchungcu/models/user/login_user_model.dart';
import 'package:congdongchungcu/models/user_model.dart';
import 'package:http/http.dart' as http;
import '../api.dart';
import '../log.dart';
import 'interface/i_services.dart';
import 'service_adapter.dart';

class LoginService implements ILoginService {
  ServiceAdapter adapter = ServiceAdapter();

  @override
  Future<String> getJWTToken(String idToken) async {
    var client = http.Client();
    String url = Api.getURL(apiPath: Api.authentication);
    try {
      var response = await client.post(Uri.parse(url), headers: {
        HttpHeaders.authorizationHeader: "Bearer $idToken"
      });
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

  @override
  Future<LoginUserModel> getUserModel(String email) async{
    var client = http.Client();
    String url = Api.getURL(apiPath: Api.users);
    LoginUserModel result;
    // var bytes = utf8.encode(password);
    // Digest sha256Password = sha256.convert(bytes);
    try {
      var response = await client.get(Uri.parse("$url/0"),
          headers: {
            'email': jsonEncode({"email": email})
          },);
      print("response.statusCode ${response.statusCode}, ${response.body}");
      if (response.statusCode == 200) {
        Map<String, dynamic> data = adapter.parseToMap(response);
        String password = data['password'];
        UserModel user = UserModel.fromJson(data);
        user.password = password;
        result = LoginUserModel(user: user, resultCode: response.statusCode);
      } else if (response.statusCode == 400) {
        result = LoginUserModel(
            resultCode: response.statusCode, errorMessage: response.body);
      }
    } catch (e) {
      Log.e(e.toString());
    } finally {
      client.close();
    }
    return result;
  }
}
