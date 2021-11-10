
import 'package:congdongchungcu/category_private/category_private_bloc.dart';
import 'package:congdongchungcu/category_private/category_private_state.dart';
import 'package:congdongchungcu/models/category_model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../dimens.dart';
import 'category_private_custom.dart';

class ListViewCategoryPrivate extends StatelessWidget {

  List<CategoryModel> listCategory;
  List<String> listIcons = [
    "assets/icons/vegetables.svg",
    "assets/icons/mom_and_baby.svg",
    "assets/icons/electronic.svg",
    "assets/icons/shoes.svg",
    "assets/icons/fashion.svg"];

  ListViewCategoryPrivate({this.listCategory});

  @override
  Widget build(BuildContext context) {
    CategoryPrivateBloc _bloc = BlocProvider.of<CategoryPrivateBloc>(context);
    return BlocBuilder<CategoryPrivateBloc,CategoryPrivateState>(
      bloc: _bloc,
      builder: (context, state) {
        //return
        return state.listCategory.isEmpty
            ? Text('List Category dont have data')
            : Container(
          height: Dimens.size110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listCategory.length,
            itemBuilder: (context, index) {
              //return
              return CategoryPrivateCustom(categoryModel: listCategory[index], icons: listIcons) ;
            },
          ),
        );
      },);
  }
}
