import 'package:congdongchungcu/bloc/edit_poi/edit_poi_bloc.dart';
import 'package:congdongchungcu/bloc/edit_poi/edit_poi_state.dart';
import 'package:congdongchungcu/bloc/edit_post/edit_post_bloc.dart';
import 'package:congdongchungcu/bloc/edit_post/edit_post_event.dart';
import 'package:congdongchungcu/bloc/edit_post/edit_post_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextfieldInputPostTitle extends StatefulWidget {
  @override
  State<TextfieldInputPostTitle> createState() =>
      _TextfieldInputPostTitleState();
}

class _TextfieldInputPostTitleState extends State<TextfieldInputPostTitle> {
  final _formKeyTitle = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    EditPostBloc bloc = BlocProvider.of<EditPostBloc>(context);
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tiêu đề:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            width: size.width,
            child: BlocBuilder<EditPostBloc, EditPostState>(
                bloc: bloc,
                builder: (context, state) {
                  return Form(
                    key: _formKeyTitle,
                    child: TextFormField(
                        maxLength: 500,
                        controller: TextEditingController()
                          ..text = state.postReceive.title,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        maxLines: 2,
                        validator: (value) {
                          if (value.length < 3) {
                            return 'Nhập ít nhất 3 ký tự';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (_formKeyTitle.currentState.validate()) {
                            state.postReceive.title = value;
                          }
                        }),
                  );
                }),
          )
        ],
      ),
    );
  }
}
