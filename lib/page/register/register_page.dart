import 'package:congdongchungcu/bloc/register/register_bloc.dart';
import 'package:congdongchungcu/bloc/register/register_event.dart';
import 'package:congdongchungcu/page/register/register_body_page.dart';
import 'package:congdongchungcu/page/register/register_header_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dimens.dart';
import '../../router.dart';

class RegisterPage extends StatefulWidget {
  final RegisterBloc bloc;

  RegisterPage(this.bloc);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterBloc get bloc => widget.bloc;

  @override
  void initState() {
    super.initState();
    bloc.listenerStream.listen((event) {
      if (event is NavigatorWelcomePageEvent) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Đăng kí thành công")));
        Navigator.of(context).pushReplacementNamed(
          Routes.profileSelection, /*arguments: event.residentIdList*/
        );
      } else if (event is ShowingSnackBarEvent) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(event.message)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                colors: [
                                  Colors.orange[600],
                                  Colors.orange[400],
                                  Colors.orange[200]
                                ],
                                end: Alignment.centerRight))),
                    Column(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: Dimens.size20,
                        ),
                        RegisterHeader(),
                        // SizedBox(height: Dimens.size20),
                        RegisterBody(),
                        // Padding(
                        //   padding: EdgeInsets.only(top: 200),
                        //   child: TextField(),
                        // )
                      ],
                    ),
                  ],
                  // child: Container(
                  //   decoration: BoxDecoration(
                  //       gradient: LinearGradient(
                  //           begin: Alignment.topCenter,
                  //           colors: [
                  //         Colors.orange[600],
                  //         Colors.orange[400],
                  //         Colors.orange[200]
                  //       ])),
                  // child: Column(
                  //   mainAxisSize: MainAxisSize.min,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: <Widget>[
                  //     SizedBox(
                  //       height: Dimens.size20,
                  //     ),
                  //     RegisterHeader(),
                  //     SizedBox(height: Dimens.size20),
                  //     Expanded(
                  //       child: RegisterBody(),
                  //     ),
                  //   ],
                  // ),
                  // ),
                ),
              );
            }),
      ),
    );
  }
}
