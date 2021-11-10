import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../app_colors.dart';
import '../../../dimens.dart';

class NotiHeader extends StatelessWidget with PreferredSizeWidget{
  const NotiHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      centerTitle: true,
      title: const Text('Quản lý tin tức',
        style: TextStyle(color: Colors.black54, fontSize: 23),),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Dimens.size50);
}