import 'package:congdongchungcu/app_colors.dart';
import 'package:congdongchungcu/bloc/add_post/add_post_event.dart';
import 'package:congdongchungcu/bloc/post/post_bloc.dart';
import 'package:congdongchungcu/bloc/post/post_event.dart';
import 'package:congdongchungcu/page/store/widgets/icon_btn_with_counter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dimens.dart';
import '../../router.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../main.dart';
import 'widgets/post_custom.dart';

class PostPage extends StatefulWidget {
  final PostBloc postBloc;

  PostPage(this.postBloc);

  @override
  State<StatefulWidget> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage>
    with AutomaticKeepAliveClientMixin {
  PostBloc get _postBloc => widget.postBloc;
  var id, checkAdd;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _postBloc.add(LoadPostEvent(currentPage: 1));

    _postBloc.listenerStream.listen((event)  async {
      if (event is NavigatorEditPostEvent)  {
        id = await Navigator.of(context).pushNamed(Routes.edit_post, arguments: event) as int;
        if (id > 0) {
          _postBloc.add(RefreshPageEvent());
          _postBloc.add(LoadPostEvent());
        }
      } else if (event is NavigatorAddPostEvent) {
        checkAdd = await Navigator.of(context).pushNamed(Routes.add_post, arguments: event) as int;
        if (checkAdd > 0){
          _postBloc.add(LoadPostEvent());
        }
      } else if (event is DeleteSuccessEvent) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Xóa thành công"),
        ));
        _postBloc.add(RefreshPageEvent());
        _postBloc.add(LoadPostEvent());
      } else if (event is DeleteFailEvent) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Đã có lỗi trong quá trình xóa, vui lòng thử lại sau."),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _postBloc,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "Cộng đồng",
            style: TextStyle(color: Colors.black54, fontSize: 23),
          ),
          centerTitle: true,
          backgroundColor: AppColors.primaryColor,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: Dimens.size10, top: 5),
              child: IconBtnWithCounter(
                svgSrc: "assets/icons/Bell.svg",
                onTap: () {
                  Navigator.of(context).pushNamed(Routes.notification);
                },
              ),
            ),
          ],
        ),
        body: PostCustom(),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 55),
          child: FloatingActionButton(
            heroTag: "writePost",
            backgroundColor: AppColors.primaryColor,
            onPressed: () async {
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => WritePost()));
              Navigator.of(context).pushNamed(Routes.add_post);
            },
            tooltip: 'Increment',
            child: const Icon(Icons.create),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _postBloc.close();
    super.dispose();
  }
}
