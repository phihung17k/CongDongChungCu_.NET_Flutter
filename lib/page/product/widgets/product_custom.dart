import 'package:congdongchungcu/bloc/productBloc/product_bloc.dart';
import 'package:congdongchungcu/bloc/productBloc/product_event.dart';
import 'package:congdongchungcu/models/product_model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../dimens.dart';

class ProductCustom extends StatelessWidget {

  final ProductModel productModel;
  ProductCustom({this.productModel});



  @override
  Widget build(BuildContext context) {
    //Bloc
    ProductBloc productBloc = BlocProvider.of<ProductBloc>(context);

    return Container(
      color: Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              //ra trang chi tiết sản phẩm

              productBloc.add(NavigatorToDetailPage(productModel));

            },
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(productModel.imagePath),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: 5,
              bottom: 5,
              left: 10,
            ),
            child: Text(
              productModel.name,
              style: TextStyle(color: Colors.black, fontSize: 17),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.size5),
                child: Image.asset(
                  "assets/images/vnd.png",
                  width: 15,
                  color: Colors.red,
                ),
              ),
              Text(
                NumberFormat.decimalPattern()
                    .format(productModel.price),
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.red,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // analyzing ...
                // productModel.status == true ?
                //     Icon(Icons.done),
                //     Text('Còn hàng'),

              ],
            ),
          )
        ],
      ),
    );
  }
}
