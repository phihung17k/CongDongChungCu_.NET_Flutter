import 'dart:io';

import 'package:congdongchungcu/app_colors.dart';
import 'package:congdongchungcu/bloc/post_manage/post_manage_bloc.dart';
import 'package:congdongchungcu/bloc/post_manage/post_manage_event.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../router.dart';

import '../../firebase_utils.dart';
import 'widgets/manage_post_custom.dart';

class PostManagePage extends StatefulWidget {
  final PostManageBloc postManageBloc;

  PostManagePage(this.postManageBloc);

  @override
  State<StatefulWidget> createState() => _PostManagePageState();
}

class _PostManagePageState extends State<PostManagePage>
    with AutomaticKeepAliveClientMixin {
  AnimationController animationController;
  // PostBloc get _postBloc => widget.postBloc;
  PostManageBloc get _postManageBloc => widget.postManageBloc;

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
  }


  @override
  void initState() {
    super.initState();
    _postManageBloc.add(LoadPostManageEvent(currentPage: 1));
    _postManageBloc.listenerStream.listen((event) {
      // if (event is SelectingPostEvent) {
      //   Navigator.pushNamed(context, Routes.comment,
      //       arguments: event.postModel);
      // }
      if (event is RejectedSuccessEvent) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Từ chối bài viết"),
        ));
         _postManageBloc.add(RefreshPageManagePostEvent());
          _postManageBloc.add(LoadPostManageEvent());
      } else if (event is RejectedFailEvent) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Đã có lỗi trong quá trình từ chối, vui lòng thử lại sau."),
        ));
      } else if (event is ApprovedSuccessEvent) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Duyệt bài thành công"),
        ));
         _postManageBloc.add(RefreshPageManagePostEvent());
         _postManageBloc.add(LoadPostManageEvent());
      } else if (event is ApprovedFailEvent) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              "Đã có lỗi trong quá trình duyệt bài, vui lòng thử lại sau."),
        ));
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _postManageBloc,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.black54),
          ),
          title: const Text(
            "Duyệt bài viết",
            style: TextStyle(color: Colors.black54, fontSize: 23),
          ),
          centerTitle: true,
          backgroundColor: AppColors.primaryColor,
        ),
        body:
            PostManageCustom(), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
