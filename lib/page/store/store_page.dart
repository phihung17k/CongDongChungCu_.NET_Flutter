import 'dart:math';

import 'package:congdongchungcu/app_colors.dart';
import 'package:congdongchungcu/bloc/store_main/store_main_bloc.dart';
import 'package:congdongchungcu/bloc/store_main/store_main_event.dart';
import 'package:congdongchungcu/bloc/store_main/store_main_state.dart';
import 'package:congdongchungcu/page/category/widgets/category_custom.dart';
import 'package:congdongchungcu/page/product/widgets/gridview_product_by_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../dimens.dart';
import '../../router.dart';
import 'widgets/home_header.dart';
import 'widgets/icon_btn_with_counter.dart';

class StorePage extends StatefulWidget {

  final StoreMainBloc bloc;
  final List<String> listIcons = [
    "assets/icons/vegetables.svg",
    "assets/icons/mom_and_baby.svg",
    "assets/icons/electronic.svg",
    "assets/icons/shoes.svg",
    "assets/icons/fashion.svg"
  ];

  StorePage(this.bloc);

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage>
    with AutomaticKeepAliveClientMixin {

  StoreMainBloc get bloc => widget.bloc;

  List<String> get listIcons => widget.listIcons;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ///fix all
    bloc.add(LoadCategoryDefaultEvent());
    bloc.add(LoadProductGeneralPageGeneralEvent());
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.primaryColor,
          title: Text(
            'Cửa hàng',
            style: TextStyle(color: Colors.black54, fontSize: Dimens.size23),
          ),
          centerTitle: true,
          actions: [
            IconBtnWithCounter(
              svgSrc: "assets/icons/Bell.svg",
              numOfitem: 3,
              onTap: () {
                Navigator.of(context).pushNamed(Routes.notification);
              },
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(Dimens.size10),
          child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return <Widget>[
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return Column(
                        children: <Widget>[
                          const HomeHeader(),
                          BlocBuilder<StoreMainBloc, StoreMainState>(
                            bloc: bloc,
                            builder: (context, state) {
                              return state.listCategory.isEmpty
                                  ? Text('no list cate')
                                  : Container(
                                      height: Dimens.size110,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: state.listCategory.length,
                                        itemBuilder: (context, index) {
                                          //return
                                          return CategoryCustom(
                                              categoryModel:
                                                  state.listCategory[index],
                                              icon: listIcons[index],
                                              onTap: () {
                                                bloc.add(SelectCategoryEvent(
                                                    categoryModelIsChoose: state
                                                        .listCategory[index]));
                                              });
                                        },
                                      ),
                                    );
                            },
                          ),
                        ],
                      );
                    }, childCount: 1),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    // floating: true,
                    delegate: _SliverAppBarDelegate(
                      minHeight: 50,
                      maxHeight: 50,
                      child: Container(
                        color: AppColors.backgroundPageColor,
                        padding: EdgeInsets.only(
                            top: Dimens.size5, bottom: Dimens.size10),
                        child: Text(
                          "Top sản phẩm",
                          style: TextStyle(
                              fontSize: Dimens.size20,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: GridViewListItem()),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // _categoryBloc.close();
    // _productGeneralBloc.close();
    bloc.close();
    super.dispose();
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  // 2
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  // 3
  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
