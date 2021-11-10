

import 'package:congdongchungcu/bloc/store_main/store_main_bloc.dart';
import 'package:congdongchungcu/bloc/store_main/store_main_event.dart';
import 'package:congdongchungcu/models/enum.dart';
import 'package:congdongchungcu/models/product_model/get_product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app_colors.dart';
import 'package:flutter/material.dart';

import '../../../dimens.dart';


class SearchField extends StatelessWidget {

  final TextEditingController _controller = TextEditingController();
  SearchField({Key key}) : super(key: key);
  
  
  @override
  Widget build(BuildContext context) {
    StoreMainBloc bloc = BlocProvider.of<StoreMainBloc>(context);
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        prefixIcon: GestureDetector(
            onTap: () {
              //gọi event search theo listCurrentProduct
              print("Chay ở search");
              print("SearchText: "+ _controller.text);
              if(_controller.text.isEmpty)
                {
                  bloc.add(LoadProductGeneralPageGeneralEvent());
                }else
                  {
                    bloc.add(SearchTopProductGeneralEvent(GetProductModel(NameOfProduct:_controller.text, status: Status.Approved)));
                  }
            },
            child: const Icon(Icons.search_rounded)
        ),
        hintText: "Tìm kiếm sản phẩm",
        errorText: null,
        contentPadding: EdgeInsets.zero,
        filled: true,
        fillColor: AppColors.primaryColor.withOpacity(Dimens.size0p1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimens.size15),
          borderSide: BorderSide.none,
        ),
      ),
      onChanged: (value) {

      },
    );
  }
}
