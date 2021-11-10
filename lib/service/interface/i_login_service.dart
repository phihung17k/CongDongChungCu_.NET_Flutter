
import 'package:congdongchungcu/models/user/login_user_model.dart';

abstract class ILoginService {
  //get jwt token authentication
  Future<String> getJWTToken(String idToken);

  Future<LoginUserModel> getUserModel(String email);
}