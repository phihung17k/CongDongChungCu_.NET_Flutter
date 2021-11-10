import 'package:flutter/material.dart';
import '../../../dimens.dart';
import '../Product.dart';
import 'product_card.dart';

class PopularProducts extends StatelessWidget {

  // List<Widget> getProducts() {
  //   List<Widget> list = [];
  //   demoProducts.forEach((element) {
  //     list.add(ProductCard(product: element));
  //   });
  //   return list;
  // }
  PopularProducts(this.listProduct);

  final List<Product> listProduct;


  @override
  Widget build(BuildContext context) {
    // formula on the Internet
    var size = MediaQuery
        .of(context)
        .size;
    final double itemHeight = size.height / 1.4;
    final double itemWidth = size.width;
    return GridView.count(
        childAspectRatio: (itemWidth / itemHeight),
        //
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        padding: EdgeInsets.all(Dimens.size10),
        crossAxisCount: 2,
        children: List.generate(
            listProduct.length,
                (index) {
              return ProductCard(
                product: listProduct[index],
              );
            }
        )
    );
  }
}