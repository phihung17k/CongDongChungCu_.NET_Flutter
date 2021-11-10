import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  final bool isValidEmail;
  final String password;
  final String email;
  final String confirmPassword;
  final bool isCheckValidPassword;
  final bool isCheckConfirmPassword;
  final String errorTextEmail;
  final String errorPassword;
  final String errorConfirmPassword;
  final int resultCreate;

  RegisterState(
      {this.isValidEmail,
      this.password,
      this.isCheckValidPassword,
      this.isCheckConfirmPassword,
      this.errorTextEmail,
      this.errorPassword,
      this.errorConfirmPassword,
      this.confirmPassword,
      this.email,
      this.resultCreate});

  RegisterState copyWith(
      {bool isValidEmail,
      String password,
      bool isCheckValidPassword,
      bool isCheckConfirmPassword,
      String errorTextEmail,
      String errorPassword,
      String errorConfirmPassword,
      String confirmPassword,
      String email,
      int resultCreate}) {
    return RegisterState(
        isValidEmail: isValidEmail ?? this.isValidEmail,
        password: password ?? this.password,
        isCheckValidPassword: isCheckValidPassword ?? this.isCheckValidPassword,
        isCheckConfirmPassword:
            isCheckConfirmPassword ?? this.isCheckConfirmPassword,
        errorTextEmail: errorTextEmail ?? this.errorTextEmail,
        errorPassword: errorPassword ?? this.errorPassword,
        errorConfirmPassword: errorConfirmPassword ?? this.errorConfirmPassword,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        email: email ?? this.email,
        resultCreate: resultCreate ?? this.resultCreate);
  }

  @override
  // TODO: implement props
  List<Object> get props => [
        isValidEmail,
        password,
        isCheckValidPassword,
        isCheckConfirmPassword,
        errorTextEmail,
        errorPassword,
        errorConfirmPassword,
        confirmPassword,
        email,
        resultCreate
      ];
}
