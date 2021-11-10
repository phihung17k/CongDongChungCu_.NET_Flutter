import 'package:congdongchungcu/bloc/store/store_event.dart';
import 'package:congdongchungcu/bloc/store/store_state.dart';
import 'package:flutter/material.dart';
import 'package:congdongchungcu/bloc/store/store_bloc.dart';
import '../../../dimens.dart';
import '/bloc/productBloc/product_bloc.dart';
import '/bloc/productBloc/product_event.dart';
import '/bloc/productBloc/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadmore/loadmore.dart';

class ListViewStoreManagement extends StatelessWidget {
  void load(BuildContext context) {
    BlocProvider.of<StoreBloc>(context).add(LoadStoreEvent());
  }

  //refresh
  void refresh(BuildContext context) {
    BlocProvider.of<StoreBloc>(context).add(LoadStoreDefault());
  }

  @override
  Widget build(BuildContext context) {
    StoreBloc storeBloc = BlocProvider.of<StoreBloc>(context);

    return BlocBuilder<StoreBloc, StoreState>(
      bloc: storeBloc,
      builder: (context, state) {
        return state.currentListStore.isEmpty
            ? Center(
          child: Text('Không có dữ liệu ListStore'),
        )
            : RefreshIndicator(
          onRefresh: () {
            return _refresh(context);
          },
          child: LoadMore(
            isFinish: !state.hasNext,
            onLoadMore: () {
              return _loadMore(context);
            },
            whenEmptyLoad: false,
            delegate: DefaultLoadMoreDelegate(),
            textBuilder: DefaultLoadMoreTextBuilder.english,
            child: ListView.builder(
              //scrollDirection: Axis.vertical,
              itemCount: state.currentListStore.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    //qua thẳng trang product page management luôn
                    storeBloc.add(NavigateToProductPageManagementEvent(state.currentListStore[index].storeId));
                  },
                  child: Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 4, bottom: 8, top: 15),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image(
                              image: AssetImage("assets/images/background.jpg"),
                              width: 120,
                              height: 110,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: Dimens.size8,),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.currentListStore[index].name,
                                style: TextStyle(
                                    fontSize: Dimens.size20,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: Dimens.size10),
                                child: Text(
                                    state.currentListStore[index].ownerStore.isEmpty ? "Không có ownerStore": state.currentListStore[index].ownerStore,
                                    style: TextStyle(
                                        fontSize: Dimens.size16
                                    )
                                ),
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // Image.asset(
                                    //   'assets/images/vnd.png',
                                    //   width: Dimens.size18,
                                    //   height: Dimens.size25,
                                    //   color: Colors.red,
                                    // ),
                                    SizedBox(width: Dimens.size5,),
                                    Text(
                                        state.currentListStore[index].phone,
                                        style: TextStyle(
                                            fontSize: Dimens.size20,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold
                                        )
                                    ),
                                  ]
                              ),
                            ]
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
    BlocProvider.of<StoreBloc>(context).add(IncrementalStoreEvent());
    //lúc này stateModel cũng có r nhưng mà chưa có hàm render lại cái view
    //phải đưa cái hàm này vào trong để add event và có state
    load(context);
    return true;
  }

  Future<bool> _refresh(BuildContext context) async {
    print("onRefresh");
    BlocProvider.of<StoreBloc>(context).add(RefreshStoreEvent());
    await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
    refresh(context);
    return true;
  }
}
