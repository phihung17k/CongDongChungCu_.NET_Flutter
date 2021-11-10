
import 'package:congdongchungcu/models/user_model.dart';

class LoginUserModel{
  UserModel user;
  int resultCode;
  String errorMessage;

  LoginUserModel({this.user, this.resultCode, this.errorMessage});
}