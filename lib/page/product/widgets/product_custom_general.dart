import 'package:congdongchungcu/models/product_model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../app_colors.dart';
import '../../../dimens.dart';

class ProductGeneralCustom extends StatelessWidget {

  final ProductModel productModel;
  final Function() onTap;
  ProductGeneralCustom({this.productModel, this.onTap});



  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: 200,
              height: 200,
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
            // padding: EdgeInsets.symmetric(vertical: Dimens.size10),
            child: Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.storefront,size: Dimens.size20, color: AppColors.primaryColor),
                  SizedBox(width: Dimens.size8),
                  Text(
                      productModel.storeName,
                    style: TextStyle(fontWeight: FontWeight.bold)
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
