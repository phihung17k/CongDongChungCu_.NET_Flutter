import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../app_colors.dart';
import '../../../dimens.dart';
import '../../../router.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SearchField(),
      Padding(
        padding: EdgeInsets.only(top: Dimens.size10),
        child: GestureDetector(
          onTap: (){
            // listen event click
            Navigator.pushNamed(context, Routes.listStore);
          },
          child: Text(
            'Danh sách các cửa hàng',
            style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 18,
                // fontWeight: FontWeight.bold,
                color: AppColors.primaryColor),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ]);
  }
}
