import 'package:congdongchungcu/models/user_model.dart';

abstract class IEditProfileService{
  Future<bool> updateInfoUser(UserModel user);
}