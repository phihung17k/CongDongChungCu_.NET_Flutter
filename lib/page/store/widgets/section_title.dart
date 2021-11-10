import 'package:congdongchungcu/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../dimens.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key key,
    this.title1,
    this.title2,
  }) : super(key: key);

  final String title1;
  final String title2;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      labelColor: AppColors.primaryColor,
      unselectedLabelColor: Colors.black,
      labelStyle: TextStyle(fontSize: 18),
      tabs: [
        Tab(text: title1),
        Tab(text: title2),
      ],
    );
  }
}
