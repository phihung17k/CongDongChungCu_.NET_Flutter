import 'package:flutter/material.dart';
import '../../../app_colors.dart';
import '../../../dimens.dart';
import '../Product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key key,
    this.width = 140,
    this.aspectRetio = 1.02,
    this.product,
  }) : super(key: key);

  final double width, aspectRetio;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: Dimens.size15, right: Dimens.size15, bottom: Dimens.size25),
      child: SizedBox(
        width: width,
        child: GestureDetector(
          onTap: () {},
          //     Navigator.pushNamed(
          //   context,
          //   DetailsScreen.routeName,
          //   arguments: ProductDetailsArguments(productBloc: productBloc),
          // ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: Dimens.size1p02,
                child: Container(
                  padding: EdgeInsets.all(Dimens.size20),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(Dimens.size0p1),
                    borderRadius: BorderRadius.circular(Dimens.size15),
                  ),
                  child: Hero(
                    tag: product.id.toString(),
                    child: Image.asset(product.images[0]),
                  ),
                ),
              ),
              SizedBox(height: Dimens.size10),
              Text(
                product.title,
                style: const TextStyle(color: Colors.black),
                textAlign: TextAlign.start,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${product.price}",
                    style: TextStyle(
                      fontSize: Dimens.size18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}