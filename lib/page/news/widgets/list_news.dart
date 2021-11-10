import '../../../bloc/news/news_bloc.dart';
import '../../../bloc/news/news_event.dart';
import '../../../bloc/news/news_state.dart';
import '../../../models/news/news_model.dart';
import '../../../repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:loadmore/loadmore.dart';
import '../../../dimens.dart';
import '../news_detail_page.dart';


class ListNews extends StatelessWidget {
  ListNews({Key key}) : super(key: key);
  UserRepository user = GetIt.I.get<UserRepository>();

  Future load(BuildContext context) async {
    BlocProvider.of<NewsBloc>(context).add(GettingAllNewsEvent());
  }

  @override
  Widget build(BuildContext context) {
    NewsBloc _bloc = BlocProvider.of<NewsBloc>(context);
    return BlocBuilder<NewsBloc, NewsState>(
        bloc: _bloc,
        builder: (context, state) {
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
                              MaterialPageRoute(builder: (context) => NewsDetailPage(list[index])),
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
    BlocProvider.of<NewsBloc>(context).add(IncreaseNewsCurrPage());
    load(context);
  }

  Future<bool> _refresh(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));
    BlocProvider.of<NewsBloc>(context).add(RefreshNews());
    load(context);
  }
}
