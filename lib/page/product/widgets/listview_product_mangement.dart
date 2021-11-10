
import '../../../dimens.dart';

import '/bloc/productBloc/product_bloc.dart';
import '/bloc/productBloc/product_event.dart';
import '/bloc/productBloc/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:loadmore/loadmore.dart';

class ListViewProductMangement extends StatelessWidget {
  void load(BuildContext context) {
    BlocProvider.of<ProductBloc>(context).add(LoadingEvent());
  }

  //refresh
  void refresh(BuildContext context) {
    BlocProvider.of<ProductBloc>(context).add(LoadingEvent());
  }

  @override
  Widget build(BuildContext context) {
    ProductBloc bloc = BlocProvider.of<ProductBloc>(context);

    return BlocBuilder<ProductBloc, ProductState>(
      bloc: bloc,
      builder: (context, state) {
        return state.currentlistProduct.isEmpty
            ? Center(
          child: Text('Không có dữ liệu'),
        )
            : RefreshIndicator(
          onRefresh: () {
            return _refresh(context);
          },
          child: LoadMore(
            isFinish: !state.hasNext,
            onLoadMore: () {
              //print("UI HasNext: "+ state.hasNext.toString());
              return _loadMore(context);
            },
            whenEmptyLoad: false,
            delegate: DefaultLoadMoreDelegate(),
            textBuilder: DefaultLoadMoreTextBuilder.english,
            child: ListView.builder(
              //scrollDirection: Axis.vertical,
              itemCount: state.currentlistProduct.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    bloc.add(NavigatorToDetailPage(state.currentlistProduct[index]));
                  },
                  child: Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 4, bottom: 8, top: 15),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image(
                                image: NetworkImage(state
                                    .currentlistProduct[index]
                                    .imagePath ??
                                    "https://lh3.googleusercontent.com/a-/AOh14Gihz-5MO46FmLtYTA27irft0lHzSAYpEF1ggRw=s96-c"),
                                width: 120,
                                height: 110,
                                fit: BoxFit.cover,

                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: Dimens.size8,),
                        Expanded(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      state.currentlistProduct[index].name,
                                      style: TextStyle(
                                          fontSize: Dimens.size20,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Padding(
                                        padding:EdgeInsets.symmetric(horizontal: Dimens.size5),
                                        child: Icon(Icons.edit)),
                                    // SizedBox(width: Dimens.size1)
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: Dimens.size10),
                                  child: Text(
                                      state.currentlistProduct[index].description,
                                      style: TextStyle(
                                          fontSize: Dimens.size16
                                      )
                                  ),
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        'assets/images/vnd.png',
                                        width: Dimens.size18,
                                        height: Dimens.size25,
                                        color: Colors.red,
                                      ),
                                      SizedBox(width: Dimens.size5,),
                                      Text(
                                          state.currentlistProduct[index].price.toString() + ' VNĐ',
                                          style: TextStyle(
                                              fontSize: Dimens.size20,
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold
                                          )
                                      ),
                                    ]
                                ),
                              ]
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Future<bool> _loadMore(BuildContext context) async {
    print("onLoadMore");
    await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
    BlocProvider.of<ProductBloc>(context).add(IncrementalProductEvent());
    //lúc này stateModel cũng có r nhưng mà chưa có hàm render lại cái view
    //phải đưa cái hàm này vào trong để add event và có state
    load(context);
    return true;
  }

  Future<bool> _refresh(BuildContext context) async {
    print("onRefresh");
    BlocProvider.of<ProductBloc>(context).add(RefreshProductEvent());
    await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
    refresh(context);
    return true;
  }
}
