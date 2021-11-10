import 'package:congdongchungcu/repository/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../dimens.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.all(Dimens.size30),
      child: Column(
        children: [
          Text(
              'Welcome,\n${GetIt.I.get<UserRepository>().fullname}',
                  style: TextStyle(
                    fontSize: Dimens.size28,
                      color: Colors.black.withOpacity(Dimens.size0p7),
                      fontWeight: FontWeight.bold
                  )
          ),
        ],
      ),
    );
  }
}