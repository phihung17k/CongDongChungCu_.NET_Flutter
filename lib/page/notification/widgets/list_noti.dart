import '../../../bloc/notification/notification_event.dart';
import 'package:loadmore/loadmore.dart';

import '../../../bloc/notification/notification_bloc.dart';
import '../../../bloc/notification/notification_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/notification/notification_model.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../dimens.dart';
import '../noti_detail_page.dart';

class ListNotification extends StatelessWidget {

  const ListNotification({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NotificationBloc _bloc = BlocProvider.of<NotificationBloc>(context);
    return BlocBuilder<NotificationBloc, NotificationState>(
        bloc: _bloc,
        builder: (context, state) {
          List<NotiModel> list = state.currentListNoti;
          bool hasNext = state.hasNext;
          return list.isNotEmpty ?
          RefreshIndicator(
            onRefresh: () async{
              var refresh = _refresh(context);
              return refresh;
            },
            child: LoadMore(
              isFinish: !hasNext,
              onLoadMore: () async{
                var bool = _loadMore(context);
                return bool;
              },
              whenEmptyLoad: true,
              delegate: const DefaultLoadMoreDelegate(),
              textBuilder: DefaultLoadMoreTextBuilder.english,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.all(Dimens.size10),
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Dimens.size15),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(Dimens.size10),
                        margin: EdgeInsets.all(Dimens.size10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => NotiDetailPage(list[index])),
                            );
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                list[index].title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimens.size20,
                                ),
                                maxLines: 2,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      list[index].createdDate,
                                      style: TextStyle(
                                        color: Colors.black26,
                                        fontSize: Dimens.size15,
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Dimens.size15,
                              ),
                              Text(
                                list[index].content,
                                style: TextStyle(fontSize: Dimens.size16),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ) : const Text('Đang tải...');
        });
  }
  Future<bool> _loadMore(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));
    BlocProvider.of<NotificationBloc>(context).add(LoadMoreEvent());
  }

  Future<bool> _refresh(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));
    BlocProvider.of<NotificationBloc>(context).add(RefreshNoti());
    BlocProvider.of<NotificationBloc>(context).add(GettingAllNotiEvent());
  }
}
