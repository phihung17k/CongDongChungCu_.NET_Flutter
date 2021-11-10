import 'package:congdongchungcu/bloc/add_post/add_post_bloc.dart';
import 'package:congdongchungcu/bloc/add_post/add_post_event.dart';
import 'package:congdongchungcu/bloc/add_post/add_post_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextfieldInputPostTitle extends StatefulWidget {
  @override
  _TextfieldInputPostTitleState createState() =>
      _TextfieldInputPostTitleState();
}

class _TextfieldInputPostTitleState extends State<TextfieldInputPostTitle> {
  final _formKeyTitle = GlobalKey<FormState>();
  final _formKeyContent = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    AddPostBloc addPostBloc = BlocProvider.of<AddPostBloc>(context);
    var size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Tiêu đề:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            width: size.width,
            child: BlocBuilder<AddPostBloc, AddPostState>(
                bloc: addPostBloc,
                builder: (context, state) {
                  return Form(
                    key: _formKeyTitle,
                    child: TextFormField(
                        validator: (value) {
                          if (value.length < 3) {
                            return 'Nhập ít nhất 3 ký tự';
                          }
                          return null;
                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(500),
                        ],
                        maxLength: 500,
                        //controller: TextEditingController()..text = state.postReceive.title,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        maxLines: 2,
                        onChanged: (value) {
                          if (_formKeyTitle.currentState.validate()){
                            // print(value);
                            addPostBloc.add(GetPostTitleEvent(title: value));
                          }
                          //state.postReceive.title = value;
                        }),
                  );
                }),
          ),
          const Text("Nội dung: ", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5,),
          Container(
            width: size.width,
            child: BlocBuilder<AddPostBloc, AddPostState>(
                bloc: addPostBloc,
                builder: (context, state) {
                  return Form(
                    key: _formKeyContent,
                    child: TextFormField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(500),
                        ],
                        maxLength: 500,
                        validator: (value) {
                          if (value.length < 3) {
                            return 'Nhập ít nhất 3 ký tự';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        maxLines: 4,
                        //controller: TextEditingController()..text = state.postReceive.content,
                        onChanged: (value) {
                          if (_formKeyContent.currentState.validate()){
                            // print(value);
                            addPostBloc.add(GetPostContentEvent(content: value));
                          }
                          //state.postReceive.content = value;
                        }
                    ),
                  );
                }
            ),
          )
        ],
      ),
    );
  }
}
