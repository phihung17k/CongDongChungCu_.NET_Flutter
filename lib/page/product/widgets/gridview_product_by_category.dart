import 'package:congdongchungcu/bloc/store_main/store_main_bloc.dart';
import 'package:congdongchungcu/bloc/store_main/store_main_state.dart';
import 'package:congdongchungcu/page/product/widgets/product_custom_general.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../router.dart';
import 'package:flutter/material.dart';


class GridViewListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    StoreMainBloc bloc = BlocProvider.of<StoreMainBloc>(context);

    return BlocBuilder<StoreMainBloc, StoreMainState>(
      bloc: bloc,
      builder: (context, state) {
        return state.listProduct.isEmpty
            ? const Text("Hiện tại kết quả search của bạn không có !!!")
            : GridView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: state.listProduct.length,
                physics: const ScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return ProductGeneralCustom(
                    productModel: state.listProduct[index],
                    onTap: () {
                      Navigator.of(context).pushNamed(Routes.productDetail,
                          arguments: state.listProduct[index]);
                    },
                  );
                },
              );
      },
    );
  }
}
