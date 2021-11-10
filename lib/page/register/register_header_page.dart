import 'package:congdongchungcu/animation/fade_animation.dart';
import 'package:congdongchungcu/page/login/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../dimens.dart';
import '../../router.dart';

class RegisterHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeAnimation(
                  delay: Dimens.size1,
                  child: Icon(
                    Icons.home_work_outlined,
                    color: Colors.white,
                    size: Dimens.size60,
                  ),
                ),
                FadeAnimation(
                  delay: Dimens.size1,
                  child: Text(
                    "Đăng kí",
                    style:
                        TextStyle(color: Colors.white, fontSize: Dimens.size40),
                  ),
                ),
              ],
            ),
          ),
          FadeAnimation(
            delay: Dimens.size1,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, right: 20),
              child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Routes.login);
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                    ),
                  ),
                  child: const Text("Trở lại trang đăng nhập",
                      style: TextStyle(
                          color: Colors.orange, fontWeight: FontWeight.bold))),
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     Container(
          //       width: 100,
          //       height: 30,
          //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white60),
          //       child: InkWell(
          //         onTap: (){
          //           Navigator.pushReplacementNamed(context, Routes.login);
          //         },
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Text("Go to Login", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
