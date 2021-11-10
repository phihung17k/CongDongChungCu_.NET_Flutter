import 'dart:io';

import 'package:congdongchungcu/app_colors.dart';
import 'package:congdongchungcu/bloc/edit_post/edit_post_bloc.dart';
import 'package:congdongchungcu/bloc/edit_post/edit_post_event.dart';
import 'package:congdongchungcu/bloc/edit_post/edit_post_state.dart';
import 'package:congdongchungcu/bloc/post/post_event.dart';
import 'package:congdongchungcu/page/edit_post/widget/input_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'widget/choose_image_gallery.dart';
import 'widget/input_title_post.dart';
import 'widget/input_content_post.dart';

class EditPostPage extends StatefulWidget {
  final EditPostBloc editPostBloc;
  EditPostPage(this.editPostBloc);
  @override
  _EditPostPageState createState() => _EditPostPageState();
}

class _EditPostPageState extends State<EditPostPage> {

  EditPostBloc get _editPostBloc => widget.editPostBloc;
  
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _editPostBloc.listenerStream.listen((event) {
      if (event is UpdatePostSuccessEvent) {
        //_editPostBloc.add(UploadFileImageToFireBaseEvent(pickedFile: e));
        Navigator.of(context).pop(event.id);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Chỉnh sửa thành công"),
        ));
      } else if (event is UpdatePostFailEvent) {
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
      NavigatorEditPostEvent event = settings.arguments as NavigatorEditPostEvent;
      _editPostBloc.add(ReceiveDataFromCommunityPage(event.postModel));
    }
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocProvider.value(
      value: _editPostBloc,
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
              title: Text("Chỉnh sửa bài viết", style: TextStyle(color: Colors.black54, fontSize: 23)),
              centerTitle: true,
              backgroundColor: AppColors.primaryColor,
            ),
            body: SingleChildScrollView(
              physics: ScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: BlocBuilder<EditPostBloc, EditPostState>(
                bloc: _editPostBloc,
                builder: (context, state){

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ChooseImageInGalleryToUpdatePost(),
                    SizedBox(
                      height: 15,
                    ),
                    TextfieldInputPostTitle(),
                    TextfieldInputPostContent(),
                    // TextfieldInputTitle(),
                    Container(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: AppColors.primaryColor,
                            textStyle: const TextStyle(fontSize: 20)),
                        onPressed: () {
                          // print("id: ${state.postReceive.id}");
                          // print("title: ${state.postReceive.title}");
                          // print("content: ${state.postReceive.content}");
                          // print("status: ${state.postReceive.status}");
                          // print("date:  ${state.postReceive.createdDate}");
                          // print("owner: ${state.postReceive.residentId}");
                          _editPostBloc.add(UpdatePostEvent(postUpdate: state.postReceive));
                        },
                        child: const Text('Lưu cập nhật', style: TextStyle(color: Colors.black),),
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
