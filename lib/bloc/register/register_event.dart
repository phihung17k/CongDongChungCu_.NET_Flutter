class RegisterEvent {}

class CheckValidEmail extends RegisterEvent {
  final String emailInput;

  CheckValidEmail({this.emailInput});
}

class CheckValidPassword extends RegisterEvent {
  final String passwordInput;

  CheckValidPassword({this.passwordInput});
}

class CheckValidConfirmPassword extends RegisterEvent {
  final String confirmPassword;

  CheckValidConfirmPassword({this.confirmPassword});
}

class HandelRegisterButton extends RegisterEvent {
  final String email;
  final String password;

  HandelRegisterButton({this.email, this.password});
}

class SignInGoogleEvent extends RegisterEvent {}

class NavigatorWelcomePageEvent extends RegisterEvent {}

class ShowingSnackBarEvent extends RegisterEvent {
  final String message;

  ShowingSnackBarEvent({this.message});
}