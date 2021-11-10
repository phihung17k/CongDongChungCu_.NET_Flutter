import 'package:congdongchungcu/app_colors.dart';
import 'package:congdongchungcu/bloc/poi_manage/poi_manage_bloc.dart';
import 'package:congdongchungcu/bloc/poi_manage/poi_manage_event.dart';
import 'package:congdongchungcu/bloc/poi_manage/poi_manage_state.dart';
import 'package:congdongchungcu/models/poi/poi_model.dart';
import 'package:congdongchungcu/page/poi_manage_page/widget/filter_bar.dart';

import 'package:congdongchungcu/page/poi_manage_page/widget/poi_card.dart';
import 'package:congdongchungcu/page/poi_manage_page/widget/search_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loadmore/loadmore.dart';
import '../../router.dart';
import 'package:flutter/material.dart';

class POIManagePage extends StatefulWidget {
  final POIManageBloc bloc;

  POIManagePage(this.bloc);

  @override
  _POIManagePageState createState() => _POIManagePageState();
}

class _POIManagePageState extends State<POIManagePage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  POIManageBloc get bloc => widget.bloc;

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
    bloc.add(GetAllPOIEvent());
    bloc.add(SelectPOITypeEvent());
    bloc.listenerStream.listen((event) {
      if (event is NavigatorEditPOIEvent) {
        Navigator.of(context).pushNamed(Routes.edit_poi, arguments: event);
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
    super.dispose();
  }

  Future load(BuildContext context) async {
    BlocProvider.of<POIManageBloc>(context).add(GetAllPOIEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Container(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Quản lý địa điểm quan tâm",
              style: TextStyle(color: Colors.black54),
            ),
            backgroundColor: AppColors.primaryColor,
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
                    //   height: 30,
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
                                    SearchBarManageUI(),
                                  ],
                                );
                              }, childCount: 1),
                            ),
                            SliverPersistentHeader(
                              pinned: true,
                              floating: true,
                              delegate: ContestTabHeader(
                                FilterBarPOIMangeUI(),
                              ),
                            ),
                          ];
                        },
                        body: Container(
                          color: Colors.white,
                          child: BlocBuilder<POIManageBloc, POIManageState>(
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
                                    onLoadMore: () {
                                      var bool = _loadMore(context);
                                      return bool;
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
                                        final int count =
                                            state.currentListPoi.length > 10
                                                ? 10
                                                : state.currentListPoi.length;
                                        final Animation<double> animation =
                                            Tween<double>(begin: 0.0, end: 1.0)
                                                .animate(CurvedAnimation(
                                                    parent: animationController,
                                                    curve: Interval(
                                                        (1 / count) * index,
                                                        1.0,
                                                        curve: Curves
                                                            .fastOutSlowIn)));
                                        animationController?.forward();
                                        // bloc.add(GetImageURLFromFireBase(imageName: state.currentListPoi[index].id.toString()));
                                        return POICard(
                                          callback: () {},
                                          poiModel: state.currentListPoi[index],
                                          //  imagePath: state.imageURL,
                                          animation: animation,
                                          animationController:
                                              animationController,
                                        );
                                      },
                                    ),
                                  ),
                                );
                              }
                              if (state.currentListPoi.isEmpty) {
                                print("No data");
                                return Center(child: Text("No data"));
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
      ),
    );
  }

  Future<bool> _loadMore(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 1000));
    BlocProvider.of<POIManageBloc>(context).add(IncreasePOICurrPage());
    load(context);
  }

  Future<bool> _refresh(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 1000));
    BlocProvider.of<POIManageBloc>(context).add(RefreshPOI());
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
