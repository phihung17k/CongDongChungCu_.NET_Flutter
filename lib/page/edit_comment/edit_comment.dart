import 'dart:io';

import 'package:congdongchungcu/bloc/comment/comment_event.dart';
import 'package:congdongchungcu/bloc/edit_comment/edit_comment_bloc.dart';
import 'package:congdongchungcu/bloc/edit_comment/edit_comment_event.dart';
import 'package:congdongchungcu/bloc/edit_comment/edit_comment_state.dart';
import 'package:congdongchungcu/bloc/edit_post/edit_post_bloc.dart';
import 'package:congdongchungcu/bloc/edit_post/edit_post_event.dart';
import 'package:congdongchungcu/bloc/edit_post/edit_post_state.dart';
import 'package:congdongchungcu/bloc/post/post_event.dart';
import 'package:congdongchungcu/models/comment/comment_model.dart';
import 'package:congdongchungcu/page/edit_comment/widget/input_content_comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../app_colors.dart';

class EditCommentPage extends StatefulWidget {
  final EditCommentBloc editCommentBloc;

  EditCommentPage(this.editCommentBloc);

  @override
  _EditCommentPageState createState() => _EditCommentPageState();
}

class _EditCommentPageState extends State<EditCommentPage> {

  EditCommentBloc get _editCommentBloc => widget.editCommentBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _editCommentBloc.listenerStream.listen((event) {
      if (event is UpdateCommmentSuccessEvent) {
        Navigator.of(context).pop(event.id);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Chỉnh sửa thành công"),
        ));
      } else if (event is UpdateCommentFailEvent) {
        Navigator.of(context).pop(0);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
          Text("Đã có lỗi trong quá trình cập nhật, vui lòng thử lại sau"),
        ));
      }
    });
  }

  @override
  void didChangeDependencies() async{
    // TODO: implement initState
    RouteSettings settings = ModalRoute.of(context).settings;
    if(settings.arguments != null){
      CommentModel model = settings.arguments as CommentModel;
      _editCommentBloc.add(ReceiveDataFromCommentPage(commentReceive: model));
    }
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocProvider.value(
      value: _editCommentBloc,
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back, color: Colors.black54),
            ),
            title: Text("Chỉnh sửa", style: TextStyle(color: Colors.black54, fontSize: 23)),
            centerTitle: true,
            backgroundColor: AppColors.primaryColor,
          ),
          body: SingleChildScrollView(
            physics: ScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: BlocBuilder<EditCommentBloc, EditCommentState>(
                bloc: _editCommentBloc,
                builder: (context, state){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      TextfieldInputCommentContent(),
                      Container(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: AppColors.primaryColor,
                              textStyle: const TextStyle(fontSize: 20)),
                          onPressed: () {
                            _editCommentBloc.add(UpdateCommentEvent(commentModelUpdate: state.commentReceive));
                          },
                          child: const Text('Cập nhật', style: TextStyle(color: Colors.black54, fontSize: 20)),
                        ),
                      ),
                    ],
                  );
                }
            ),
          )),
    );
  }
}
