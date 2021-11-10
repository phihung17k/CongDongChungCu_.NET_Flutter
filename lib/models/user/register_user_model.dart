
import 'package:congdongchungcu/models/user_model.dart';

class RegisterUserModel{
  UserModel user;
  int resultCode;
  String errorMessage;

  RegisterUserModel({this.user, this.resultCode, this.errorMessage});
}