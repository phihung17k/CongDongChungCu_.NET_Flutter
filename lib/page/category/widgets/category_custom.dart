import 'package:congdongchungcu/bloc/category/category_bloc.dart';
import 'package:congdongchungcu/bloc/category/category_event.dart';
import 'package:congdongchungcu/bloc/category/category_state.dart';
import 'package:congdongchungcu/models/category_model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../app_colors.dart';
import '../../../dimens.dart';

class CategoryCustom extends StatelessWidget {

  final CategoryModel categoryModel;
  final String icon;
  final Function() onTap;

  CategoryCustom({this.categoryModel, this.icon, this.onTap});


  @override
  Widget build(BuildContext context) {

    // CategoryBloc _CategoryBloc = BlocProvider.of<CategoryBloc>(context);

    return GestureDetector(
      onTap: onTap,
      //     () {
      //   //add event chọn category đó
      //   _CategoryBloc.add(SelectCategoryEvent(categoryModelIsChoose:categoryModel ));
      // },
      // child: Card(
      //   color: state.isCategoryChoose.name == categoryModel.name ? Colors.deepOrangeAccent : Colors.white,
      //   margin: EdgeInsets.symmetric(horizontal: 10),
      //   child: Column(
      //     children: [
      //       Text(categoryModel.name),
      //     ],
      //   ),
      // ),
      child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: Dimens.size15, vertical: Dimens.size10),
              padding: EdgeInsets.all(Dimens.size10),
              decoration: BoxDecoration(
                color: AppColors.backgroundCategoryCard,
                borderRadius: BorderRadius.circular(Dimens.size10),
              ),
              child: SvgPicture.asset(
                icon,
                color: Colors.deepOrange,
                width: Dimens.size40,
                height: Dimens.size40,
                fit: BoxFit.contain,
              ),
            ),
            Text(
                categoryModel.name,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: Dimens.size15)
            ),
            const SizedBox(height: 10)
          ]

      ),
    );


  }
}
