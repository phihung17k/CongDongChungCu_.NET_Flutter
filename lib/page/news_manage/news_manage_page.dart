import '../../../bloc/news_manage/news_manage_bloc.dart';
import '../../../bloc/news_manage/news_manage_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../dimens.dart';
import '../../router.dart';
import 'widgets/add_news_button.dart';
// import 'widgets/date_picker.dart';
import 'widgets/list_news_manage.dart';
import 'widgets/noti_header.dart';
import 'widgets/search_news.dart';

class NewsManagePage extends StatefulWidget {
  final NewsManageBloc bloc;

  const NewsManagePage(this.bloc, {Key key}) : super(key: key);

  @override
  State<NewsManagePage> createState() => _NewsManagePageState();
}

class _NewsManagePageState extends State<NewsManagePage> {
  NewsManageBloc get _bloc => widget.bloc;
var id, isCreated;
  @override
  void initState() {
    super.initState();
    _bloc.add(GettingAllNewsEvent());
    _bloc.listenerStream.listen((event) async {
      if (event is EditNewsNavigator){
        int id = await Navigator.of(context).pushNamed(Routes.edit_news, arguments: event) as int;
        if (id > 0){
          _bloc.add(RefreshNews());
          _bloc.add(GettingAllNewsEvent());
        }
      } else if (event is DeleteSuccess){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Xóa thành công"),
        ));
        _bloc.add(RefreshNews());
        _bloc.add(GettingAllNewsEvent());
      } else if (event is DeleteFail){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Đã có lỗi trong quá trình xóa, vui lòng thử lại sau."),
        ));
      } else if (event is CreateNewsNavigator){
        isCreated = await Navigator.of(context).pushNamed(Routes.create_news) as bool;
        if (isCreated){
          _bloc.add(RefreshNews());
          _bloc.add(GettingAllNewsEvent());
        }
      }
      // else if (event is DetailNewsNavigator){
      //   Navigator.of(context).pushNamed(
      //       Routes.detail_news, arguments: event.detailModel);
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
            resizeToAvoidBottomInset: false,
          appBar: const NotiHeader(),
          body: Container(
              padding: EdgeInsets.all(Dimens.size10),
              child: Column(
                children: [
                  SearchNewsField(),
                  // BasicDateField(),
                  Expanded(child: ListNewsManage()),
                ],
              )),
          floatingActionButton: const AddNewsButton(),
        ),
      ),
    );
  }
}
