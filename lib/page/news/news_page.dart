import 'package:congdongchungcu/page/store/widgets/icon_btn_with_counter.dart';

import '../../bloc/news/news_event.dart';

import '../../router.dart';
import 'widgets/list_news.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_colors.dart';
import '../../bloc/news/news_bloc.dart';
import 'package:flutter/material.dart';

import '../../dimens.dart';

class NewsPage extends StatefulWidget {
  final NewsBloc bloc;

  const NewsPage(this.bloc, {Key key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage>
    with AutomaticKeepAliveClientMixin {
  NewsBloc get _bloc => widget.bloc;

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _bloc.add(GettingAllNewsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.primaryColor,
          centerTitle: true,
          title: const Text('Tin tức',
            style: TextStyle(color: Colors.black54, fontSize: 23),),
          actions: [
            IconBtnWithCounter(
              svgSrc: "assets/icons/Bell.svg",
              onTap: () {
                Navigator.of(context).pushNamed(Routes.notification);
              },
            ),
          ],
        ),
        body: Stack(children: <Widget>[
          Padding(padding: EdgeInsets.all(Dimens.size10), child: ListNews()),
        ]),
      ),
    );
  }
}
