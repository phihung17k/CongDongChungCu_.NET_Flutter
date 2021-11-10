import 'package:congdongchungcu/models/user/register_user_model.dart';
import 'package:congdongchungcu/models/user_model.dart';

abstract class IRegisterService{
    Future<RegisterUserModel> createUser( String password, String email);
    Future<String> getJWTToken(String idToken);
}