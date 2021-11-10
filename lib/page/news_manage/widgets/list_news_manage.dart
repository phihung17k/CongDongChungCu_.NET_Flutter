import '../../../bloc/news_manage/news_manage_bloc.dart';
import '../../../bloc/news_manage/news_manage_event.dart';
import '../../../bloc/news_manage/news_manage_state.dart';
import '../../../models/news/get_news_model.dart';
import '../../../models/news/news_model.dart';
import '../../../repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:loadmore/loadmore.dart';
import '../../../dimens.dart';
import '../news_detail_manage_page.dart';


class ListNewsManage extends StatelessWidget {
  ListNewsManage({Key key}) : super(key: key);
  UserRepository user = GetIt.I.get<UserRepository>();

  Future load(BuildContext context) async {
    BlocProvider.of<NewsManageBloc>(context).add(GettingAllNewsEvent());
  }

  @override
  Widget build(BuildContext context) {
    NewsManageBloc _bloc = BlocProvider.of<NewsManageBloc>(context);
    return BlocBuilder<NewsManageBloc, NewsManageState>(
        bloc: _bloc,
        builder: (context, NewsManageState state) {
          List<NewsModel> list = state.currentListNews;
          bool hasNext = state.hasNext;
          return list.isNotEmpty ? RefreshIndicator(
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
              textBuilder: DefaultLoadMoreTextBuilder.english,
              child: ListView.builder(
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
                              MaterialPageRoute(builder: (context) => NewsDetailManagePage(list[index])),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      list[index].title,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: Dimens.size20,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ),
                                  PopupMenuButton(
                                      icon: const Icon(Icons.more_horiz),
                                      itemBuilder: (context) => [
                                            PopupMenuItem(
                                              child: GestureDetector(
                                                child: const Text(
                                                    "Chỉnh sửa tin tức"),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  _bloc.add(EditNewsNavigator(
                                                      editModel: list[index]));
                                                },
                                              ),
                                              value: 1,
                                            ),
                                            PopupMenuItem(
                                              child: GestureDetector(
                                                child: const Text("Xóa tin"),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          (BuildContext ctx) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                              'Xóa tin?'),
                                                          content: const Text(
                                                              'Bạn có muốn xóa tin này không?'),
                                                          actions: [
                                                            TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(context).pop();
                                                                  _bloc.add(DeleteNews(
                                                                      id: list[index].id));
                                                                },
                                                                child:const Text('Có')),
                                                            TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(context).pop();
                                                                },
                                                                child:
                                                                    const Text('Không'))
                                                          ],
                                                        );
                                                      });
                                                },
                                              ),
                                              value: 2,
                                            )
                                          ])
                                ],
                              ),
                              SizedBox(
                                height: Dimens.size25,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Từ: ' +
                                            user.selectedResident.apartmentModel.name,
                                        style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: Dimens.size15,
                                        ),
                                        maxLines: 1,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.flag,
                                        color: Colors.orange,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      list[index].createdDate,
                                      style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: Dimens.size15,
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(
                                color: Colors.black26,
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
    BlocProvider.of<NewsManageBloc>(context).add(IncreaseNewsCurrPage());
    load(context);
  }

  Future<bool> _refresh(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));
    BlocProvider.of<NewsManageBloc>(context).add(RefreshNews());
    load(context);
  }
}
