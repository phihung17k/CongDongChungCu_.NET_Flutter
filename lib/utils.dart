import 'dart:convert';
import 'log.dart';

class Utils {

  static Map<String, dynamic> fromJWT(String token) {
    Map<String, dynamic> payloadMap = {};
    try{
      final parts = token.split('.');
      final payload = parts[1];
      var normalized = base64Url.normalize(payload);
      var resp = utf8.decode(base64Url.decode(normalized));
      payloadMap = json.decode(resp);
    } catch (e){
      Log.e("$e");
    }
    return payloadMap;
  }
}
