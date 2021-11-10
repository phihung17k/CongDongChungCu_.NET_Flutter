
import 'package:congdongchungcu/bloc/post_manage/post_manage_bloc.dart';
import 'package:congdongchungcu/bloc/post_manage/post_manage_event.dart';
import 'package:congdongchungcu/bloc/post_manage/post_manage_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadmore/loadmore.dart';

import 'manage_thread_item.dart';

class PostManageCustom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PostManageBloc _postManageBloc = BlocProvider.of<PostManageBloc>(context);
    return BlocBuilder<PostManageBloc, PostManageState>(
      bloc: _postManageBloc,
      builder: (context, state) {
        return state.currentListPosts.isEmpty
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.error,
                    color: Colors.grey[700],
                    size: 64,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text(
                      'There is no post',
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ))
            : RefreshIndicator(
                onRefresh: () {
                  var refresh = _refresh(context);
                  return refresh;
                },
                child: LoadMore(
                  isFinish: !state.hasNext,
                  onLoadMore: () {
                    var bool = _loadMore(context);
                    return bool;
                  },
                  whenEmptyLoad: true,
                  delegate: const DefaultLoadMoreDelegate(),
                  textBuilder: DefaultLoadMoreTextBuilder.english,
                  child: ListView.builder(
                    itemCount: state.currentListPosts.length,
                    itemBuilder: (context, index) {
                      if (index == state.currentListPosts.length - 1) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 35),
                          child: ManageThreadItem(
                            postModel: state.currentListPosts[index],
                          ),
                        );
                      };
                      print("lenghCheck: ${state.currentListPosts.length}");
                      return ManageThreadItem(
                        postModel: state.currentListPosts[index],
                        threadItemAction: () {
                          // postBloc.add(SelectingPostEvent(postModel: state.currentListPosts[index]));
                        },
                      );
                      // return SizedBox();
                    },
                  ),
                ),
              );
      },
    );
  }

  Future<bool> _loadMore(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));
    BlocProvider.of<PostManageBloc>(context).add(IncreaseNewsCurrPageManageEvent());
    load(context);
  }

  Future<bool> _refresh(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));
    BlocProvider.of<PostManageBloc>(context).add(RefreshPageManagePostEvent());
    load(context);
  }

  Future load(BuildContext context) async {
    BlocProvider.of<PostManageBloc>(context).add(LoadPostManageEvent());
  }
}
