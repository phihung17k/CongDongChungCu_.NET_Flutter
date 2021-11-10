import 'dart:convert';

import 'package:congdongchungcu/models/user_model.dart';
import 'package:congdongchungcu/repository/user_repository.dart';
import 'package:get_it/get_it.dart';
import '../api.dart';
import '../log.dart';
import 'interface/i_edit_profile_service.dart';
import 'package:http/http.dart' as http;

class EditProfileService extends IEditProfileService{

  @override
  Future<bool> updateInfoUser(UserModel user) async {
    var client = http.Client();
    String url = Api.getURL(apiPath: Api.users);
    try {
      var response = await client.put(Uri.parse(url+"/${user.id}"),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(<String, dynamic>{
            "id": user.id,
            "username": user.username,
            "password": user.password,
            "fullname": user.fullName,
            "phone": user.phone,
            "email": user.email,
            "is_system_admin": false,
            "status": true
          }));
      if (response.statusCode == 200) {
        print('success');
        UserRepository userRepository = GetIt.I.get<UserRepository>();
        userRepository.fullname = user.fullName;
        userRepository.username = user.username;
        userRepository.email = user.email;
        userRepository.phone = user.phone;
        // userRepository.
        print('userRepository.fullname: ${userRepository.fullname}');
        print('userRepository.username: ${userRepository.username}');
        // print('userRepository.password: ${}');
        print('userRepository.email: ${userRepository.email}');
        print('userRepository.phone: ${userRepository.phone}');


        return true;
      } else {
        print(response.statusCode);
        print(url);
      }
    } catch (e) {
      Log.e(e);
    } finally {
      client.close();
    }
  }

}