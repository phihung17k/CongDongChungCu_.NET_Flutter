import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:congdongchungcu/models/user/login_user_model.dart';
import 'package:congdongchungcu/models/user_model.dart';
import 'package:congdongchungcu/page/main_page/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../firebase_utils.dart';
import 'package:get_it/get_it.dart';
import '../../repository/user_repository.dart';
import '../../base_bloc.dart';
import '../../bloc/login/login_event.dart';
import '../../bloc/login/login_state.dart';
import '../../service/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../utils.dart';
import 'package:crypto/crypto.dart';

class LoginBloc extends BaseBloc<LoginEvent, LoginState> {
  final ILoginService service;

  LoginBloc(this.service)
      : super(LoginState(
          isValidEmail: false,
          isCheckValidPassword: false,
        )) {
    on((event, emit) async {
      if (event is SignInGoogleEvent) {
        UserCredential credential = await FirebaseUtils.signInWithGoogle();
        if (credential != null) {
          await saveUserData(credential.user);
          listener.add(NavigatorWelcomePageEvent());
        }
      } else if (event is CheckValidEmailEvent) {
        Pattern pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
        RegExp regex = RegExp(pattern);
        if (event.email.trim().isEmpty) {
          emit(state.copyWith(
            isValidEmail: false,
            errorTextEmail: "Email không được trống",
            // email: null,
            // resultCreate: -1
          ));
        } else {
          if (!regex.hasMatch(event.email)) {
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
      } else if (event is CheckValidPasswordEvent) {
        if (event.password.trim().isEmpty) {
          emit(state.copyWith(
            isCheckValidPassword: false,
            errorPassword: "Mật khẩu không được trống",
            // resultCreate: -1
          ));
        } else {
          emit(state.copyWith(
            isCheckValidPassword: true,
            errorPassword: null,
            // resultCreate: -1
          ));
        }
      } else if (event is LoginEmailEvent) {
        String email = event.email;
        String password = event.password;
        print("email $email and $password");
        LoginUserModel model = await service.getUserModel(email);
        if (model != null) {
          if (model.resultCode == 200) {
            UserModel userModel = model.user;
            var bytes = utf8.encode(password);
            Digest sha256Password = sha256.convert(bytes);
            print("sha256Password.toString() ${sha256Password.toString()}");
            print("userModel.password ${userModel.password}");
            if (sha256Password.toString() == userModel.password) {
              await saveUserDataLogin(
                  userModel, "https://i.stack.imgur.com/l60Hf.png");
              listener.add(NavigatorWelcomePageEvent());
            } else {
              listener.add(ShowingSnackBarEvent(
                  message: "Email hoặc mật khẩu không đúng"));
            }
          } else if (model.resultCode == 400) {
            listener.add(ShowingSnackBarEvent(message: model.errorMessage));
          }
        } else {
          listener.add(ShowingSnackBarEvent(
              message: "Email hoặc mật khẩu không đúng"));
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

  Future saveUserDataLogin(UserModel userModel, String imagePath) async {
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
