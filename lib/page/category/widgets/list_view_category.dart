import 'package:congdongchungcu/bloc/category/category_bloc.dart';
import 'package:congdongchungcu/bloc/category/category_state.dart';
import 'package:congdongchungcu/models/category_model/category_model.dart';
import 'package:congdongchungcu/page/category/widgets/category_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../dimens.dart';

class ListViewCategory extends StatelessWidget {
  List<CategoryModel> listCategory;
  List<String> listIcons = [
    "assets/icons/vegetables.svg",
    "assets/icons/mom_and_baby.svg",
    "assets/icons/electronic.svg",
    "assets/icons/shoes.svg",
    "assets/icons/fashion.svg"
  ];

  ListViewCategory({this.listCategory});

  @override
  Widget build(BuildContext context) {
    CategoryBloc _bloc = BlocProvider.of<CategoryBloc>(context);
    return BlocBuilder<CategoryBloc, CategoryState>(
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
                    return CategoryCustom(
                        categoryModel: listCategory[index],
                        icon: listIcons[index]);
                  },
                ),
              );
      },
    );
  }
}
