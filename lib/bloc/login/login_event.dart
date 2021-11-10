
class LoginEvent{}

class SignInGoogleEvent extends LoginEvent{}

class SignOut extends LoginEvent{}

class NavigatorWelcomePageEvent extends LoginEvent{}

class CheckValidEmailEvent extends LoginEvent{
  final String email;

  CheckValidEmailEvent(this.email);
}

class CheckValidPasswordEvent extends LoginEvent{
  final String password;

  CheckValidPasswordEvent(this.password);
}

class LoginEmailEvent extends LoginEvent{
  final String email;
  final String password;

  LoginEmailEvent({this.email, this.password});
}

class ShowingSnackBarEvent extends LoginEvent{
  final String message;

  ShowingSnackBarEvent({this.message});
}