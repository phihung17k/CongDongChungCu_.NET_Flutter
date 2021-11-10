import 'package:congdongchungcu/bloc/poi/poi_bloc.dart';
import 'package:congdongchungcu/bloc/poi/poi_event.dart';
import 'package:congdongchungcu/bloc/poi/poi_state.dart';
import 'package:congdongchungcu/models/poi/poi_model.dart';
import 'package:congdongchungcu/page/poi/widget/filter_bar.dart';
import 'package:congdongchungcu/page/poi/widget/search_bar.dart';
import 'package:congdongchungcu/page/store/widgets/icon_btn_with_counter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadmore/loadmore.dart';
import '../../app_colors.dart';
import '../../dimens.dart';
import '../../router.dart';
import 'widget/poi_list_view.dart';
import 'package:flutter/material.dart';

class POIPage extends StatefulWidget {
  final POIBloc bloc;

  POIPage(this.bloc);
  @override
  _POIPageState createState() => _POIPageState();
}

class _POIPageState extends State<POIPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  POIBloc get bloc => widget.bloc;

  AnimationController animationController;
  List<POIModel> poiList;
  final ScrollController _scrollController = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
    // bloc.add(GetAllPOIEvent());
    print("init poi");
    bloc.add(GetAllPOIEvent());
    bloc.add(SelectPOITypeEvent());
    bloc.listenerStream.listen((event) {
      if (event is NavigatorEditPOIEvent) {
        Navigator.of(context).pushNamed(Routes.edit_poi, arguments: event);
      } else if (event is NavigatorToGoogleMapEvent){
        Navigator.pushNamed(context, Routes.map, arguments: event.model);
      }
    });
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 100));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    bloc.close();
    super.dispose();
  }

  Future load(BuildContext context) async {
    BlocProvider.of<POIBloc>(context).add(GetAllPOIEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Địa điểm",
          style: TextStyle(color: Colors.black54, fontSize: 23),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        actions: [
           Padding(
          padding: EdgeInsets.only(right: Dimens.size10, top: 5),
          child: IconBtnWithCounter(
            svgSrc: "assets/icons/Bell.svg",
            numOfitem: 3,
            onTap: () {
              Navigator.of(context).pushNamed(Routes.notification);
            },
          ),
        ),
        ],
      ),
        body: Stack(
          children: <Widget>[
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Column(
                children: <Widget>[
                  // SizedBox(
                  //   height: 5,
                  // ),
                  Expanded(
                    child: NestedScrollView(
                      controller: _scrollController,
                      headerSliverBuilder:
                          (BuildContext context, bool innerBoxIsScrolled) {
                        return <Widget>[
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                              return Column(
                                children: <Widget>[
                                  SearchBarUI(),
                                ],
                              );
                            }, childCount: 1),
                          ),
                          SliverPersistentHeader(
                            pinned: true,
                            floating: true,
                            delegate: ContestTabHeader(
                              FilterBarUI(),
                            ),
                          ),
                        ];
                      },
                      body: Container(
                        color: Colors.white,
                        child: BlocBuilder<POIBloc, POIState>(
                          bloc: bloc,
                          builder: (context, state) {
                            bool hasNext = state.hasNext;
                            if (state.currentListPoi.isNotEmpty) {
                              return RefreshIndicator(
                                onRefresh: () {
                                  var refresh = _refresh(context);
                                  return refresh;
                                },
                                child: LoadMore(
                                  isFinish: !hasNext,
                                  onLoadMore: () async {
                                    return await _loadMore(context);
                                  },
                                  whenEmptyLoad: true,
                                  delegate: const DefaultLoadMoreDelegate(),
                                  textBuilder:
                                      DefaultLoadMoreTextBuilder.english,
                                  child: ListView.builder(
                                    itemCount: state.currentListPoi.length,
                                    padding: const EdgeInsets.only(top: 8),
                                    scrollDirection: Axis.vertical,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      // final int count =
                                      //     state.currentListPoi.length > 10
                                      //         ? 10
                                      //         : state.currentListPoi.length;
                                      final Animation<double> animation =
                                          Tween<double>(begin: 0.0, end: 1.0)
                                              .animate(CurvedAnimation(
                                                  parent: animationController,
                                                  curve: Interval(
                                                      (1 / state.currentListPoi.length) * index,
                                                      1.0,
                                                      curve: Curves
                                                          .fastOutSlowIn)));
                                      animationController?.forward();
                                      return POIListView(
                                        callback: () {
                                          bloc.add(NavigatorToGoogleMapEvent(
                                            model: state.currentListPoi[index]
                                          ));
                                        },
                                        poiModel: state.currentListPoi[index],
                                        animation: animation,
                                        animationController:
                                            animationController,
                                      );
                                    },
                                  ),
                                ),
                              );
                            } if(state.currentListPoi.isEmpty) {
                              return Center(child: Text("No data to show"));
                            }
                            return Center(child: CircularProgressIndicator());
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: missing_return
  Future<bool> _loadMore(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));
    BlocProvider.of<POIBloc>(context).add(IncreaseNewsCurrPage());
    load(context);
  }

  Future<bool> _refresh(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));
    BlocProvider.of<POIBloc>(context).add(RefreshNews());
    load(context);
  }
}

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  ContestTabHeader(
    this.searchUI,
  );
  final Widget searchUI;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return searchUI;
  }

  @override
  double get maxExtent => 52.0;

  @override
  double get minExtent => 52.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
