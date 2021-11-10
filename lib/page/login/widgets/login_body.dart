import 'package:congdongchungcu/bloc/login/login_state.dart';
import 'package:congdongchungcu/page/register/register_page.dart';
import 'package:flutter/cupertino.dart';

import '../../../animation/fade_animation.dart';
import '../../../bloc/login/login_bloc.dart';
import '../../../bloc/login/login_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../dimens.dart';
import '../../../router.dart';
import 'input_field.dart';

class LoginBody extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    LoginBloc _bloc = BlocProvider.of<LoginBloc>(context);
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimens.size60),
              topRight: Radius.circular(Dimens.size60))),
      padding: EdgeInsets.all(Dimens.size30),
      child: BlocBuilder<LoginBloc, LoginState>(
        bloc: _bloc,
        builder: (context, state) {
          return Column(
            children: <Widget>[
              // SizedBox(
              //   height: Dimens.size40,
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: FadeAnimation(
                  delay: Dimens.size1p4,
                  child: InputField(
                    controller: emailController,
                    hintText: "Email",
                    onChanged: (value) {
                      _bloc.add(CheckValidEmailEvent(emailController.text));
                    },
                    errorText: state.isValidEmail ? null : state.errorTextEmail,
                  ),
                ),
              ),
              // SizedBox(height: Dimens.size20),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: FadeAnimation(
                  delay: Dimens.size1p4,
                  child: InputField(
                    controller: passwordController,
                    hintText: "Mật khẩu",
                    obscureText: true,
                    onChanged: (value) {
                      _bloc.add(
                          CheckValidPasswordEvent(passwordController.text));
                    },
                    errorText:
                        state.isCheckValidPassword ? null : state.errorPassword,
                  ),
                ),
              ),
              // SizedBox(
              //   height: Dimens.size30,
              // ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 10),
                child: FadeAnimation(
                    delay: Dimens.size1p5,
                    child: InkWell(
                      onTap: () {},
                      child: const Text(
                        "Quên mật khẩu?",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )),
              ),
              // SizedBox(
              //   height: Dimens.size30,
              // ),
              FadeAnimation(
                delay: Dimens.size1p6,
                child: ElevatedButton(
                  child: const Text("Đăng nhập",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimens.size90, vertical: 12),
                    primary: Colors.orange[600],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimens.size50),
                    ),
                  ),
                  onPressed: () {
                    if (emailController.text.trim().isNotEmpty &&
                        passwordController.text.trim().isNotEmpty) {
                      _bloc.add(LoginEmailEvent(
                          password: passwordController.text,
                          email: emailController.text));
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: FadeAnimation(
                    delay: Dimens.size1p7,
                    child: const Text(
                      "Hoặc đăng nhập với",
                      style: TextStyle(color: Colors.grey),
                    )),
              ),
              // SizedBox(
              //   height: Dimens.size10,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FadeAnimation(
                      delay: Dimens.size1p8,
                      child: InkWell(
                        onTap: () {
                          _bloc.add(SignInGoogleEvent());
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.orange[600],
                            child: const Icon(FontAwesomeIcons.google,
                                color: Colors.white),
                          ),
                        ),
                      )),
                ],
              ),
              FadeAnimation(
                delay: Dimens.size1p9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Chưa có tài khoản? ",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacementNamed(Routes.register);
                        },
                        child: Text(
                          "Đăng kí",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange[900],
                              fontSize: 17),
                        ))
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
