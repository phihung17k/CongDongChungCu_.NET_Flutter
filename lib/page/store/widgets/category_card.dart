import '../../../app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../dimens.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key key,
    this.icon,
    this.text,
    this.onTap,
  }) : super(key: key);

  final String icon, text;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: Dimens.size55,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(Dimens.size15),
              height: Dimens.size55,
              width: Dimens.size55,
              decoration: BoxDecoration(
                color: AppColors.backgroundCategoryCard,
                borderRadius: BorderRadius.circular(Dimens.size10),
              ),
              child: SvgPicture.asset(
                icon,
                color: Colors.deepOrange,
              ),
            ),
            SizedBox(height: Dimens.size5),
            Text(text, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
