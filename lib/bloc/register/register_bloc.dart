import 'package:congdongchungcu/bloc/register/register_event.dart';
import 'package:congdongchungcu/bloc/register/register_state.dart';
import 'package:congdongchungcu/models/user/register_user_model.dart';
import 'package:congdongchungcu/models/user_model.dart';
import 'package:congdongchungcu/repository/user_repository.dart';
import 'package:congdongchungcu/service/interface/i_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../base_bloc.dart';
import '../../firebase_utils.dart';
import '../../utils.dart';

class RegisterBloc extends BaseBloc<RegisterEvent, RegisterState> {
  final IRegisterService service;

  RegisterBloc(this.service)
      : super(RegisterState(
          isValidEmail: false,
          isCheckValidPassword: false,
          isCheckConfirmPassword: false,
          email: null,
          password: null,
          confirmPassword: null,
          //  resultCreate: 0
          errorTextEmail: null,
          errorPassword: null,
          errorConfirmPassword: null,
        )) {
    on((event, emit) async {
      if (event is CheckValidEmail) {
        Pattern pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
        RegExp regex = RegExp(pattern);
        if (event.emailInput.trim().isEmpty) {
          emit(state.copyWith(
            isValidEmail: false,
            errorTextEmail: "Email không được trống",
            // email: null,
            // resultCreate: -1
          ));
        } else {
          if (!regex.hasMatch(event.emailInput)) {
            emit(state.copyWith(
              isValidEmail: false,
              errorTextEmail: "Email không hợp lệ",
              // email: null,
              // resultCreate: -1
            ));
          } else {
            emit(state.copyWith(
              isValidEmail: true,
              errorTextEmail: null,
              // email: event.emailInput,
              // resultCreate: -1
            ));
          }
        }
      }
      if (event is CheckValidPassword) {
        if (event.passwordInput.trim().isEmpty) {
          emit(state.copyWith(
            password: "",
            isCheckValidPassword: false,
            errorPassword: "Mật khẩu không được trống",
            // resultCreate: -1
          ));
        } else {
          emit(state.copyWith(
            password: event.passwordInput,
            isCheckValidPassword: true,
            errorPassword: null,
            // resultCreate: -1
          ));
        }
        // else {
        //   if (event.passwordInput == state.confirmPassword) {
        //     emit(state.copyWith(
        //         password: event.passwordInput,
        //         isCheckValidPassword: true,
        //         errorPassword: "",
        //         resultCreate: -1));
        //   } else {
        //     emit(state.copyWith(
        //         password: event.passwordInput,
        //         isCheckValidPassword: false,
        //         errorPassword: "Mật khẩu không khớp",
        //         resultCreate: -1));
        //   }
        // }
      }
      if (event is CheckValidConfirmPassword) {
        if(state.password != null && state.password.trim().isNotEmpty){
          if (event.confirmPassword == state.password) {
            emit(state.copyWith(
              isCheckConfirmPassword: true,
              errorConfirmPassword: null,
              // confirmPassword: event.confirmPassword,
              // resultCreate: -1
            ));
          } else {
            emit(state.copyWith(
              isCheckConfirmPassword: false,
              errorConfirmPassword: "Mật khẩu không khớp",
              // confirmPassword: event.confirmPassword,
              // resultCreate: -1
            ));
          }
        }
        // if (event.confirmPassword.isEmpty) {
        //   emit(state.copyWith(
        //       isCheckValidPassword: false,
        //       errorPassword: "Xác nhận mật khẩu",
        //       confirmPassword: null,
        //       resultCreate: -1));
        // } else {
        //   if (event.confirmPassword == state.password) {
        //     emit(state.copyWith(
        //         isCheckValidPassword: true,
        //         errorPassword: "",
        //         confirmPassword: event.confirmPassword,
        //         resultCreate: -1));
        //   } else {
        //     emit(state.copyWith(
        //         isCheckValidPassword: false,
        //         errorPassword: "Mật khẩu không khớp",
        //         confirmPassword: event.confirmPassword,
        //         resultCreate: -1));
        //   }
        // }
      }
      if (event is HandelRegisterButton) {
        if (event.email != null &&
            event.password != null) {
          print("email ${event.email} and ${event.password}");
          if (state.isValidEmail && state.isCheckValidPassword) {
            RegisterUserModel data =
                await service.createUser(event.password, event.email);
            if (data != null) {
              if (data.resultCode == 201) {
                UserModel userModel = data.user;
                await saveUserDataRegister(
                    userModel, "https://i.stack.imgur.com/l60Hf.png");
                listener.add(NavigatorWelcomePageEvent());
                // emit(state.copyWith(
                //     errorTextEmail: "", resultCreate: 201, isValidEmail: true));
              }
              if (data.resultCode == 400) {
                print("data.errorMessage ${data.errorMessage}");
                listener.add(ShowingSnackBarEvent(message: data.errorMessage));
              }
              // else if (result == 201) {
              //   emit(state.copyWith(
              //       errorTextEmail: "", resultCreate: 201, isValidEmail: true));
              // } else {
              //   state.resultCreate = 0;
              //   emit(state.copyWith(
              //       errorTextEmail: "Đăng ký không thành công", resultCreate: 0));
              // }
            }
          }
        }
        // else if (state.email == null) {
        //   emit(state.copyWith(
        //       errorTextEmail: "Nhập email", isValidEmail: false, email: null));
        // } else if (state.password == null) {
        //   emit(state.copyWith(
        //       errorPassword: "Nhập mật khẩu",
        //       isCheckValidPassword: false,
        //       password: null));
        // } else if (state.confirmPassword == null) {
        //   emit(state.copyWith(
        //       errorPassword: "Xác nhận mật khẩu",
        //       isCheckValidPassword: false,
        //       confirmPassword: null));
        // }
      }

      if (event is SignInGoogleEvent) {
        UserCredential credential = await FirebaseUtils.signInWithGoogle();
        if (credential != null) {
          await saveUserData(credential.user);
          listener.add(NavigatorWelcomePageEvent());
        }
      }
    });
  }

  Future saveUserData(User credentialUser) async {
    String idToken = await credentialUser.getIdToken();
    String imagePath = credentialUser.photoURL;

    String authToken = await service.getJWTToken(idToken);
    Map<String, dynamic> userMap = Utils.fromJWT(authToken);
    UserRepository user = GetIt.I.get<UserRepository>();
    user.id = int.parse(userMap['id']);
    user.idToken = idToken;
    user.username = userMap['username'];
    user.email = userMap['email'];
    user.fullname = userMap['fullname'];
    user.phone = userMap['phone'];
    user.imagePath = imagePath;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> userInfo = [
      "${user.id}",
      idToken,
      user.username,
      user.email,
      user.fullname,
      user.phone,
      user.imagePath
    ];
    await preferences.setStringList("userInfo", userInfo);
    await FirebaseUtils.saveUserImage(user.id, user.imagePath);
  }

  Future saveUserDataRegister(UserModel userModel, String imagePath) async {
    UserRepository user = GetIt.I.get<UserRepository>();
    user.id = userModel.id;
    user.username = userModel.username;
    user.email = userModel.email;
    user.fullname = userModel.fullName;
    user.phone = userModel.phone;
    user.imagePath = imagePath;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> userInfo = [
      "${user.id}",
      "",
      user.username,
      user.email,
      user.fullname,
      user.phone,
      user.imagePath
    ];
    await preferences.setStringList("userInfo", userInfo);
    // await FirebaseUtils.saveUserImage(user.id, user.imagePath);
  }
}
