import 'package:congdongchungcu/bloc/comment/comment_bloc.dart';
import 'package:congdongchungcu/bloc/comment/comment_event.dart';
import 'package:congdongchungcu/bloc/comment/comment_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_colors.dart';
import '../../router.dart';
import 'widget/comment_custom.dart';
import 'widget/intput_comment.dart';

class CommentPage extends StatefulWidget {
  final CommentBloc commentBloc;

  CommentPage(this.commentBloc);

  @override
  _CommentPageState createState() => _CommentPageState();
}

var id, checkCreated;
class _CommentPageState extends State<CommentPage>{
  CommentBloc get _commentBloc => widget.commentBloc;

  @override
  void initState() {
    super.initState();
    //_commentBloc.add(LoadCommentEvent());
    _commentBloc.listenerStream.listen((event) async {
      if (event is NavigatorEditCommentEvent) {
        id = await Navigator.of(context)
            .pushNamed(Routes.edit_comment, arguments: event.commentModel) as int;
        if (id > 0) {
          _commentBloc.add(RefreshPageCommentEvent());
          _commentBloc.add(LoadCommentEvent());
        }
      }
      else if (event is DeleteSuccessCommentEvent) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Xóa thành công"),
        ));
        _commentBloc.add(RefreshPageCommentEvent());
        _commentBloc.add(LoadCommentEvent());
      } else if (event is DeleteFailCommentEvent) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Đã có lỗi trong quá trình xóa, vui lòng thử lại sau."),
        ));
      }
      else if (event is AddCommentSuccessEvent) {
        // Navigator.of(context).pop(true);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Tạo thành công"),
        ));
        _commentBloc.add(RefreshPageCommentEvent());
        _commentBloc.add(LoadCommentEvent());
      } else if (event is AddCommentFailEvent) {
        // Navigator.of(context).pop(false);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Đã có lỗi trong quá trình, vui lòng thử lại sau."),
        ));
      }
    });
  }

  @override
  void didChangeDependencies() async {
       super.didChangeDependencies();
    // TODO: implement didChangeDependencies
    RouteSettings settings = ModalRoute.of(context).settings;
    if (settings.arguments != null && _commentBloc.state.isFirst) {
      int postId = settings.arguments as int;
     _commentBloc.add(GetPostIdEvent(postId: postId));
      _commentBloc.add(LoadCommentEvent());
      print("postIdComPage: ${postId}");
    }
 
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider.value(
      value: _commentBloc,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back, color: Colors.black54),
              ),
              title: const Text('Bình luận',
              style: TextStyle(color: Colors.black54, fontSize: 23)),
              centerTitle: true,
              backgroundColor: AppColors.primaryColor,
            ),
            body: BlocBuilder<CommentBloc, CommentState>(
              bloc: _commentBloc,
              builder: (context, state) {
                return Column(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 6),
                        child: CommentCustom(),
                      ),
                    ),
                    Row( // BUTTON ADD
                      children: [
                        SizedBox(width: 10,),
                        Expanded(child: AddComment()),
                        // Container(
                        //   margin: EdgeInsets.symmetric(horizontal: 2.0),
                        //   child: IconButton(
                        //       icon: Icon(Icons.send, color: AppColors.primaryColor, size: 35,),
                        //       onPressed: () {
                        //        _commentBloc.add(AddNewCommentEvent(
                        //             content: state.content, postId: state.postId));
                        //       }),
                        // ),
                      ],
                    ),
                  ],
                );
              },
            )
            ),
      ),
    );
  }
}


