import 'package:flutter/material.dart';
import '../../../dimens.dart';
import 'category_card.dart';


class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/icons/cutlery.svg", "text": "Thực phẩm"},
      {"icon": "assets/icons/fashion.svg", "text": "Thời trang"},
      {"icon": "assets/icons/productBloc.svg", "text": "Tiêu dùng"},
      {"icon": "assets/icons/electronic.svg", "text": "Điện tử"},
      {"icon": "assets/icons/electronic.svg", "text": "Điện tử"},
      {"icon": "assets/icons/electronic.svg", "text": "Điện tử"},
      {"icon": "assets/icons/electronic.svg", "text": "Điện tử"},
      {"icon": "assets/icons/electronic.svg", "text": "Điện tử"},
    ];
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Dimens.size20, horizontal: Dimens.size10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.height,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              categories.length,
              (index) => CategoryCard(
                icon: categories[index]["icon"],
                text: categories[index]["text"],
                onTap: () {},
              ),
            ),
          ),
        ),
      ),
    );
  }
}
