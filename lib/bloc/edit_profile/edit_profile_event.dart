import 'package:congdongchungcu/models/user_model.dart';

class EditProfileEvent{}

class NavigateToProfilePageEvent extends EditProfileEvent{}

class UpdateProfileEvent extends EditProfileEvent{
  final UserModel userModel;

  UpdateProfileEvent({this.userModel});

}

