import 'dart:convert';
import 'package:http/http.dart';
import '../log.dart';

class ServiceAdapter{

  String parseToString(Response response){
    Log.d("------------------start------------------");
    Log.d("response: ${response?.toString()}");
    Log.d("status code:${response?.statusCode}");
    Log.d("headers: ${response?.headers}");
    Log.d("body: ${response?.body}");
    Log.d("-------------------end-------------------");
    if(response != null){
      return response.body;
    }
    return null;
  }

  List<dynamic> parseToList(Response response){
    Log.d("------------------start------------------");
    Log.d("response: ${response?.toString()}");
    Log.d("status code:${response?.statusCode}");
    Log.d("headers: ${response?.headers}");
    Log.d("body: ${response?.body}");
    Log.d("-------------------end-------------------");
    if(response != null){
      return jsonDecode(response.body) as List<dynamic>;
    }
    return null;
  }

  Map<String, dynamic> parseToMap(Response response){
    Log.d("------------------start------------------");
    Log.d("response: ${response?.toString()}");
    Log.d("status code:${response?.statusCode}");
    Log.d("headers: ${response?.headers}");
    Log.d("body: ${response?.body}");
    Log.d("-------------------end-------------------");
    if(response != null){
      return jsonDecode(response.body) as Map<String, dynamic>;
    }
    return null;
  }
}