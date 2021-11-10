import 'package:congdongchungcu/bloc/edit_comment/edit_comment_bloc.dart';
import 'package:congdongchungcu/bloc/edit_comment/edit_comment_state.dart';
import 'package:congdongchungcu/bloc/edit_poi/edit_poi_bloc.dart';
import 'package:congdongchungcu/bloc/edit_poi/edit_poi_state.dart';
import 'package:congdongchungcu/bloc/edit_post/edit_post_bloc.dart';
import 'package:congdongchungcu/bloc/edit_post/edit_post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class TextfieldInputCommentContent extends StatefulWidget {

  @override
  _TextfieldInputCommentContentState createState() => _TextfieldInputCommentContentState();
}

class _TextfieldInputCommentContentState extends State<TextfieldInputCommentContent> {

  @override
  Widget build(BuildContext context) {
      EditCommentBloc bloc = BlocProvider.of<EditCommentBloc>(context);
    var size = MediaQuery.of(context).size;
    return Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Nội dung: ",style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 5,),
                    Container(
                      width: size.width,
                      child: BlocBuilder<EditCommentBloc, EditCommentState>(
                        bloc: bloc,
                      builder: (context, state) {
                        return TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        maxLines: 4,
                        controller: TextEditingController()..text = state.commentReceive.content,
                         onChanged: (value){
                          state.commentReceive.content = value;
                        }
                        );
                      }
                      ),
                    )
                  ],
                ),
              );
  }
}