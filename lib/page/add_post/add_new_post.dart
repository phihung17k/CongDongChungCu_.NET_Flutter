import 'dart:io';

import 'package:congdongchungcu/bloc/add_post/add_post_bloc.dart';
import 'package:congdongchungcu/bloc/add_post/add_post_event.dart';
import 'package:congdongchungcu/bloc/add_post/add_post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../app_colors.dart';
import 'widget/choose_image_gallery_add_post.dart';
import 'widget/input_add_post.dart';
import 'widget/input_content_add_post.dart';

class AddPostPage extends StatefulWidget {
  final AddPostBloc addPostBloc;
  AddPostPage(this.addPostBloc);

  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {

  AddPostBloc get _addPostBloc => widget.addPostBloc;

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _addPostBloc.listenerStream.listen((event) {
      if (event is AddPostSuccessEvent) {
        Navigator.of(context).pop(event.id);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Tạo thành công, bài viết đang đợi được duyệt"),
        ));
        // _addPostBloc.add(RefreshPageEvent());
        // _addPostBloc.add(LoadPostEvent());
      } else if (event is AddPostFailEvent) {
        Navigator.of(context).pop(0);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
          Text("Đã có lỗi trong quá trình tạo bài viết, vui lòng thử lại sau"),
        ));
      }
    });
  }

   @override
    void didChangeDependencies() async{
    // TODO: implement initState
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocProvider.value(
      value: _addPostBloc,
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
              title: Text("Tạo bài viết", style: TextStyle(color: Colors.black54, fontSize: 23)),
              backgroundColor: AppColors.primaryColor,
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              physics: ScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: BlocBuilder<AddPostBloc, AddPostState>(
                bloc: _addPostBloc,
                builder: (context, state){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ChooseImageInGalleryToAdd(),
                    SizedBox(
                      height: 12,
                    ),
                    TextfieldInputPostTitle(),
                    Container(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                  primary: AppColors.primaryColor,
                            textStyle: const TextStyle(fontSize: 20)),
                        onPressed: () {
                          if (state.title != null && state.content != null) {
                            _addPostBloc.add(AddNewPostEvent(
                                title: state.title, content: state.content));
                          }
                        },
                        child: const Text('Đăng bài viết', style: TextStyle(color: Colors.black54, fontSize: 20)),
                      ),
                    ),
                  ],
                );
                }
              ),
            )),
      ),
    );
  }
}
