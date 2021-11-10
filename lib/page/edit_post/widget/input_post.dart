import 'package:congdongchungcu/bloc/edit_poi/edit_poi_bloc.dart';
import 'package:congdongchungcu/bloc/edit_poi/edit_poi_state.dart';
import 'package:congdongchungcu/bloc/edit_post/edit_post_bloc.dart';
import 'package:congdongchungcu/bloc/edit_post/edit_post_event.dart';
import 'package:congdongchungcu/bloc/edit_post/edit_post_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextfieldInputTitle extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final int maxLine;
  final Function(String value) onChanged;

  TextfieldInputTitle(
      @required this.title, @required this.controller,
      @required this.maxLine, @required this.onChanged);

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
            title,
            // "Tiêu đề:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            width: size.width,
            child: BlocBuilder<EditPostBloc, EditPostState>(
                bloc: bloc,
                builder: (context, state) {
                  return TextField(
                      maxLength: 500,
                      controller: TextEditingController()
                        ..text = state.postReceive.title,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      maxLines: maxLine,
                      onChanged: onChanged
                  );})
          )
        ],
      ),
    );
  }
}
