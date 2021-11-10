import 'package:congdongchungcu/bloc/comment/comment_bloc.dart';
import 'package:congdongchungcu/bloc/comment/comment_event.dart';
import 'package:congdongchungcu/bloc/comment/comment_state.dart';
import 'package:congdongchungcu/models/comment/comment_model.dart';
import 'package:congdongchungcu/models/posts/post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app_colors.dart';

class AddComment extends StatelessWidget {
  const AddComment({Key key}) : super(key: key);

//   @override
//   _AddCommentState createState() => _AddCommentState();
// }
//
//
// class _AddCommentState extends State<AddComment> {
  @override
  Widget build(BuildContext context) {
    // CommentBloc _commentBloc = BlocProvider.of<CommentBloc>(context);
    // return BlocBuilder<CommentBloc, CommentState>(
    //   bloc: _commentBloc,
    //   builder: (context, state) {
    //     return TextFormField(
    //       decoration: InputDecoration.collapsed(
    //           hintText: "Nhập bình luận tại đây...."),
    //         onChanged: (valueContent) {
    //         _commentBloc.add(GetCommentContentEvent(content: valueContent));
    //       },
    //     );
    //   },
    // );
    CommentBloc _commentBloc = BlocProvider.of<CommentBloc>(context);
    var _commentContentController = TextEditingController();
    var size = MediaQuery
        .of(context)
        .size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: size.width,
            child:
            // BlocBuilder<CommentBloc, CommentState>(
            //     bloc: _commentBloc,
            //     builder: (context, state) {
            //       return
                    Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _commentContentController,
                          maxLength: 500,
                          decoration: InputDecoration(
                            hintText: "Nhập bình luận tại đây",
                            // border: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(5)),
                          ),
                          maxLines: 1,
                          //controller: TextEditingController()..text = state.postReceive.content,
                          // onChanged: (value) {
                          //   addCommentBloc.add(GetCommentContentEvent(content: value));
                          //   //state.postReceive.content = value;
                          // }
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 2.0),
                        child: IconButton(
                            icon: Icon(Icons.send, color: AppColors.primaryColor, size: 35,),
                            onPressed: () {
                              if (_commentContentController.text.isNotEmpty) {
                                FocusScope.of(context).unfocus();
                                _commentBloc.add(AddNewCommentEvent(
                                    content: _commentContentController.text,
                                    postId: _commentBloc.state.postId));
                              }
                            }),
                      ),
                    ],

                  ),

            //     }
            // ),
          )
        ],
      ),
    );
  }
}
