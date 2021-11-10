import 'package:congdongchungcu/bloc/edit_poi/edit_poi_bloc.dart';
import 'package:congdongchungcu/bloc/edit_poi/edit_poi_state.dart';
import 'package:congdongchungcu/bloc/edit_post/edit_post_bloc.dart';
import 'package:congdongchungcu/bloc/edit_post/edit_post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextfieldInputPostContent extends StatefulWidget {
  TextfieldInputPostContent({Key key}) : super(key: key);

  @override
  State<TextfieldInputPostContent> createState() =>
      _TextfieldInputPostContentState();
}

class _TextfieldInputPostContentState extends State<TextfieldInputPostContent> {
  final _formKeyContent = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    EditPostBloc bloc = BlocProvider.of<EditPostBloc>(context);
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Nội dung: ", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(
            height: 5,
          ),
          Container(
            width: size.width,
            child: BlocBuilder<EditPostBloc, EditPostState>(
                bloc: bloc,
                builder: (context, state) {
                  return Form(
                    key: _formKeyContent,
                    child: TextFormField(
                        maxLength: 500,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        maxLines: 4,
                        controller: TextEditingController()
                          ..text = state.postReceive.content,
                        validator: (value) {
                          if (value.length < 3) {
                            return 'Nhập ít nhất 3 ký tự';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (_formKeyContent.currentState.validate()) {
                            state.postReceive.content = value;
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
