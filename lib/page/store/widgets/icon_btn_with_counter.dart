import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app_colors.dart';
import '../../../dimens.dart';

class IconBtnWithCounter extends StatelessWidget {
  final String svgSrc;
  final int numOfitem;
  final void Function() onTap;

  const IconBtnWithCounter({
    Key key,
    this.svgSrc,
    this.numOfitem = 0,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(Dimens.size100),
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.all(Dimens.size12),
            height: Dimens.size46,
            width: Dimens.size46,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(Dimens.size0p1),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(svgSrc),
          ),
          numOfitem != 0
              ? Positioned(
                  top: Dimens.size2,
                  right: Dimens.size2,
                  child: Container(
                    height: Dimens.size16,
                    width: Dimens.size16,
                    decoration: BoxDecoration(
                      color: AppColors.bellColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                          width: Dimens.size1p5, color: Colors.white),
                    ),
                    child: Center(
                      child: Text(
                        "$numOfitem",
                        style: TextStyle(
                          fontSize: Dimens.size10,
                          height: Dimens.size1,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
