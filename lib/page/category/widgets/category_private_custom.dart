
import 'package:congdongchungcu/category_private/category_private_bloc.dart';
import 'package:congdongchungcu/category_private/category_private_event.dart';
import 'package:congdongchungcu/category_private/category_private_state.dart';
import 'package:congdongchungcu/models/category_model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../app_colors.dart';
import '../../../dimens.dart';

class CategoryPrivateCustom extends StatelessWidget {

  CategoryModel categoryModel;
  final List<String> icons;

  CategoryPrivateCustom({this.categoryModel, this.icons});


  @override
  Widget build(BuildContext context) {

    CategoryPrivateBloc _categoryPrivateBloc = BlocProvider.of<CategoryPrivateBloc>(context);

    return BlocBuilder<CategoryPrivateBloc,CategoryPrivateState>(
      bloc: _categoryPrivateBloc,
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            //add event chọn category đó
            _categoryPrivateBloc.add(SelectCategoryPrivateEvent(categoryModelIsChoose:categoryModel ));


          },
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
                    icons.elementAt(categoryModel.id - 1),
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
                SizedBox(height: 10)

              ]

          ),
        ) ;
      },
    );


  }
}
