import 'dart:async';
import 'package:congdongchungcu/firebase_utils.dart';
import 'package:congdongchungcu/repository/user_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/splash/splash_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/splash/splash_event.dart';
import '../app_colors.dart';
import '../bloc/splash/splash_bloc.dart';
import 'package:flutter/material.dart';
import '../dimens.dart';
import '../router.dart';

class SplashPage extends StatefulWidget {
  final SplashBloc bloc;

  SplashPage(this.bloc);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SplashBloc get bloc => widget.bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 10), () {
      bloc.add(SplashEvent());
    });
    Future.delayed(const Duration(seconds: 4), () async {
      UserRepository user = GetIt.I.get<UserRepository>();
      SharedPreferences preferences = await SharedPreferences.getInstance();
      if (preferences.containsKey("userInfo")) {
        List<String> userInfo = preferences.getStringList("userInfo");
        user.id = int.parse(userInfo[0]);
        user.idToken = userInfo[1];
        user.username = userInfo[2];
        user.email = userInfo[3];
        user.fullname = userInfo[4];
        user.phone = userInfo[5];
        user.imagePath = userInfo[6];
        //
        if (preferences.containsKey("selectedResidentId")) {
          int residentId = preferences.getInt("selectedResidentId");
          //get auth Token
          bloc.add(InitiatingUserEvent(residentId));
        } else {
          Navigator.of(context).pushReplacementNamed(Routes.profileSelection);
        }
      } else {
        await FirebaseUtils.logout();
        Navigator.of(context).pushReplacementNamed(Routes.login);
      }
    });

    bloc.listenerStream.listen((event) {
      if (event is CompletedInitiationEvent) {
        Navigator.of(context).pushReplacementNamed(Routes.main);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: BlocBuilder(
          bloc: bloc,
          builder: (context, SplashState state) {
            return AnimatedOpacity(
              duration: const Duration(seconds: 3),
              opacity: state.opacity,
              child: Text(
                "Cộng Đồng Chung Cư",
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: Dimens.size25,
                    fontWeight: FontWeight.bold),
              ),
            );
          },
        ),
      ),
    );
  }
}
