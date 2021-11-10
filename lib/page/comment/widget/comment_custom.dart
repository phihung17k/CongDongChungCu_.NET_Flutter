import 'package:congdongchungcu/bloc/comment/comment_bloc.dart';
import 'package:congdongchungcu/bloc/comment/comment_event.dart';
import 'package:congdongchungcu/bloc/comment/comment_state.dart';
import 'package:congdongchungcu/models/comment/comment_model.dart';
import 'package:congdongchungcu/models/posts/post_model.dart';
import 'package:congdongchungcu/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:loadmore/loadmore.dart';

import 'comment_item.dart';
import '../../post/widgets/thread_item.dart';

class CommentCustom extends StatelessWidget {
  var residentId = GetIt.I.get<UserRepository>().selectedResident.id;
  var residentIsGroupAdmin =
      GetIt.I.get<UserRepository>().selectedResident.isAdmin;

  CommentCustom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CommentBloc _commentBloc = BlocProvider.of<CommentBloc>(context);
    return BlocBuilder<CommentBloc, CommentState>(
        bloc: _commentBloc,
        builder: (context, state) {
          print('list ' + state.currentListComments.length.toString());
          return state.currentListComments.isNotEmpty
              ? RefreshIndicator(
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
                      shrinkWrap: true,
                      itemCount: state.currentListComments.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            CommentItem(
                              commentModel: state.currentListComments[index],
                              size: MediaQuery.of(context).size,
                            ),
                            (residentId ==
                                        state.currentListComments[index]
                                            .residentId ||
                                    residentIsGroupAdmin == true)
                                ? PopupMenuButton<int>(
                                    itemBuilder: (context) {
                                      if (residentId !=
                                              state.currentListComments[index]
                                                  .residentId &&
                                          residentIsGroupAdmin == true) {
                                        return [
                                          PopupMenuItem(
                                            onTap: () {
                                              _commentBloc.add(
                                                  DeleteCommentEvent(
                                                      commentId: state
                                                          .currentListComments[
                                                              index]
                                                          .commentId,
                                                      ownerCommentId: state
                                                          .currentListComments[
                                                              index]
                                                          .residentId));
                                            },
                                            value: 2,
                                            child: Row(
                                              children: const <Widget>[
                                                Icon(Icons.delete, size: 18),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8.0),
                                                  child: Text('Xoá bình luận'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ];
                                      }
                                      return [
                                        PopupMenuItem(
                                          onTap: () {
                                            _commentBloc.add(
                                                NavigatorEditCommentEvent(
                                                    commentModel: state
                                                            .currentListComments[
                                                        index]));
                                          },
                                          value: 1,
                                          child: Row(
                                            children: const <Widget>[
                                              Icon(Icons.edit, size: 18),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 8.0),
                                                child:
                                                    Text('Chỉnh sửa bình luận'),
                                              ),
                                            ],
                                          ),
                                        ),
                                        PopupMenuItem(
                                          onTap: () {
                                            _commentBloc.add(DeleteCommentEvent(
                                                commentId: state
                                                    .currentListComments[index]
                                                    .commentId,
                                                ownerCommentId: state
                                                    .currentListComments[index]
                                                    .residentId));
                                          },
                                          value: 2,
                                          child: Row(
                                            children: const <Widget>[
                                              Icon(Icons.delete, size: 18),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 8.0),
                                                child: Text('Xoá bình luận'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ];
                                    },
                                    initialValue: 1,
                                    onCanceled: () {
                                      // print("You have canceled the menu.");
                                    },
                                  )
                                : Container(),
                          ],
                        );
                      }, //updateMyDataToMain: widget.updateMyData,
                      // replyComment: _replyComment);
                    ),
                  ),
                )
              : const Center(
                  child: Text("Chưa có bình luận nào"),
                );
        });
  }

  Future<bool> _loadMore(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    BlocProvider.of<CommentBloc>(context)
        .add(IncreaseNewsCurrPageCommentEvent());
    load(context);
  }

  Future<bool> _refresh(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    BlocProvider.of<CommentBloc>(context).add(RefreshPageCommentEvent());
    load(context);
  }

  Future load(BuildContext context) async {
    BlocProvider.of<CommentBloc>(context).add(LoadCommentEvent());
  }
}
