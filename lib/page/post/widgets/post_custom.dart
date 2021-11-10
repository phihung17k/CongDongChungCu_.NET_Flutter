import 'package:congdongchungcu/bloc/post/post_bloc.dart';
import 'package:congdongchungcu/bloc/post/post_event.dart';
import 'package:congdongchungcu/bloc/post/post_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadmore/loadmore.dart';

import 'thread_item.dart';

class PostCustom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PostBloc postBloc = BlocProvider.of<PostBloc>(context);
    return BlocBuilder<PostBloc, PostState>(
      bloc: postBloc,
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
                      'Không có bài đăng nào gần đây',
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
                          child: ThreadItem(
                            postModel: state.currentListPosts[index],
                          ),
                        );
                      }

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: ThreadItem(
                          postModel: state.currentListPosts[index],
                          //myData: widget.myData[index],
                          // updateMyDataToMain: widget.updateMyData,
                          threadItemAction: () {
                            // postBloc.add(SelectingPostEvent(postModel: state.currentListPosts[index]));
                          },
                          //threadItemAction: (){},
                          //isFromThread: true,
                          // parentContext: context,
                        ),
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
    await Future.delayed(const Duration(seconds: 2));
    await BlocProvider.of<PostBloc>(context).add(IncreaseNewsCurrPageEvent());
    load(context);
  }

  Future<bool> _refresh(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    BlocProvider.of<PostBloc>(context).add(RefreshPageEvent());
    load(context);
  }

  Future load(BuildContext context) async {
    BlocProvider.of<PostBloc>(context).add(LoadPostEvent());
  }
}
