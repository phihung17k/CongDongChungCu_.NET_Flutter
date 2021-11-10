import 'package:congdongchungcu/models/user_model.dart';
import 'package:equatable/equatable.dart';

class EditProfileState extends Equatable {
  final UserModel userModelReceive;
  final String fullname;
  final String email;
  final String phone;

  // final UserRepository userRepositoryReceive;

  EditProfileState({this.userModelReceive, this.fullname, this.email, this.phone});

  EditProfileState copyWith(
      {UserModel userModelReceive, String fullname, String email, String phone}
      ) {
    return EditProfileState(
        userModelReceive: userModelReceive ?? this.userModelReceive,
        fullname: fullname ?? this.fullname,
        email: email ?? this.email,
        phone: phone ?? this.phone
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [userModelReceive, fullname, email, phone];
}
