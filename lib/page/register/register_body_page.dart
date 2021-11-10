import 'package:congdongchungcu/animation/fade_animation.dart';
import 'package:congdongchungcu/bloc/register/register_bloc.dart';
import 'package:congdongchungcu/bloc/register/register_event.dart';
import 'package:congdongchungcu/bloc/register/register_state.dart';
import 'package:congdongchungcu/page/login/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../dimens.dart';
import '../../router.dart';

class RegisterBody extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    RegisterBloc bloc = BlocProvider.of<RegisterBloc>(context);
    return BlocProvider.value(
      value: bloc,
      child: Container(
        height: MediaQuery.of(context).size.height - 200,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimens.size60),
                topRight: Radius.circular(Dimens.size60))),
        padding: EdgeInsets.all(Dimens.size30),
        child: BlocBuilder<RegisterBloc, RegisterState>(
            bloc: bloc,
            builder: (context, state) {
              return Column(
                children: <Widget>[
                  SizedBox(
                    height: Dimens.size20,
                  ),
                  FadeAnimation(
                    delay: Dimens.size1p4,
                    child: InputField(
                      controller: emailController,
                      hintText: "Email",
                      onChanged: (value) {
                        // print("email $value");
                        bloc.add(CheckValidEmail(emailInput: value));
                      },
                      errorText:
                          state.isValidEmail ? null : state.errorTextEmail,
                    ),
                  ),
                  SizedBox(height: Dimens.size20),
                  FadeAnimation(
                    delay: Dimens.size1p4,
                    child: InputField(
                      controller: passwordController,
                      hintText: "Mật khẩu",
                      obscureText: true,
                      onChanged: (value) {
                        bloc.add(CheckValidPassword(passwordInput: value));
                      },
                      errorText: state.isCheckValidPassword
                          ? null
                          : state.errorPassword,
                    ),
                  ),
                  SizedBox(
                    height: Dimens.size20,
                  ),
                  FadeAnimation(
                    delay: Dimens.size1p4,
                    child: InputField(
                      controller: confirmController,
                      hintText: "Xác nhận mật khẩu",
                      obscureText: true,
                      onChanged: (value) {
                        bloc.add(CheckValidConfirmPassword(
                            confirmPassword: value));
                      },
                      errorText: state.isCheckConfirmPassword
                          ? null
                          : state.errorConfirmPassword,
                    ),
                  ),
                  SizedBox(
                    height: Dimens.size18,
                  ),
                  FadeAnimation(
                    delay: Dimens.size1p6,
                    child: ElevatedButton(
                      child: const Text("Đăng kí",
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
                        if (passwordController.text.isNotEmpty &&
                            passwordController.text == confirmController.text) {
                          bloc.add(HandelRegisterButton(
                              email: emailController.text,
                              password: passwordController.text));
                        }
                        // print("state result create");
                        // print(state.resultCreate);

                        // if(state.resultCreate == 201){
                        //   Navigator.of(context).pop(Routes.login);
                        //   ScaffoldMessenger.of(context)
                        //               .showSnackBar(const SnackBar(
                        //             content: Text("Đăng ký thành công"),
                        //           ));
                        // }
                        // else if (state.resultCreate == 400){
                        //   state.errorTextEmail = "Email này đã tồn tại";
                        //   ScaffoldMessenger.of(context)
                        //               .showSnackBar(const SnackBar(
                        //             content: Text("Email này đã tồn tại"),
                        //           ));
                        // }
                        // else if(state.resultCreate == 0){
                        //   ScaffoldMessenger.of(context)
                        //               .showSnackBar(const SnackBar(
                        //             content: Text("Đăng ký không thành công"),
                        //           ));
                        // }
                      },
                    ),
                  ),
                  SizedBox(
                    height: Dimens.size10,
                  ),
                  FadeAnimation(
                      delay: Dimens.size1p7,
                      child: const Text(
                        "Hoặc đăng kí bằng",
                        style: TextStyle(color: Colors.grey),
                      )),
                  SizedBox(
                    height: Dimens.size10,
                  ),
                  FadeAnimation(
                      delay: Dimens.size1p8,
                      child: InkWell(
                        onTap: () {
                          bloc.add(SignInGoogleEvent());
                        },
                        child: CircleAvatar(
                            backgroundColor: Colors.orange[900],
                            child: const Icon(FontAwesomeIcons.google,
                                color: Colors.white)),
                      )),
                ],
              );
            }),
      ),
    );
  }
}
