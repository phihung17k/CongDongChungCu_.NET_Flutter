import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final bool isValidEmail;
  final bool isCheckValidPassword;
  final String errorTextEmail;
  final String errorPassword;

  LoginState(
      {this.isValidEmail,
      this.isCheckValidPassword,
      this.errorTextEmail,
      this.errorPassword});

  LoginState copyWith(
      {bool isValidEmail,
      bool isCheckValidPassword,
      String errorTextEmail,
      String errorPassword}) {
    return LoginState(
        isValidEmail: isValidEmail ?? this.isValidEmail,
        isCheckValidPassword: isCheckValidPassword ?? this.isCheckValidPassword,
        errorTextEmail: errorTextEmail ?? this.errorTextEmail,
        errorPassword: errorPassword ?? this.errorPassword);
  }

  @override
  // TODO: implement props
  List<Object> get props =>
      [isValidEmail, isCheckValidPassword, errorTextEmail, errorPassword];
}
