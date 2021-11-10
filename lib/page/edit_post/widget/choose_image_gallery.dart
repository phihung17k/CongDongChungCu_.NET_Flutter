import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:congdongchungcu/bloc/add_post/add_post_bloc.dart';
import 'package:congdongchungcu/bloc/add_post/add_post_event.dart';
import 'package:congdongchungcu/bloc/add_post/add_post_state.dart';
import 'package:congdongchungcu/bloc/edit_post/edit_post_bloc.dart';
import 'package:congdongchungcu/bloc/edit_post/edit_post_event.dart';
import 'package:congdongchungcu/bloc/edit_post/edit_post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ChooseImageInGalleryToUpdatePost extends StatefulWidget {
  @override
  _ChooseImageInGalleryToUpdatePostState createState() => _ChooseImageInGalleryToUpdatePostState();
}

class _ChooseImageInGalleryToUpdatePostState extends State<ChooseImageInGalleryToUpdatePost> {
  File imageFile;
  final picker = ImagePicker();

  Future<void> _showChoiceDialog(BuildContext context) {
    EditPostBloc editPostBloc = BlocProvider.of<EditPostBloc>(context);
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Chọn ảnh từ"),
            content: SingleChildScrollView(
              child: BlocBuilder<EditPostBloc, EditPostState>(
                  bloc: editPostBloc,
                  builder: (context, state){
                    return ListBody(
                      children: [
                        GestureDetector(
                          child: Text("Thư viện"),
                          onTap: () async{
                            // _openGallery(context);
                            var pickedFile = await picker.pickImage(
                                source: ImageSource.gallery);
                            // this.setState(() {
                            imageFile = File(pickedFile.path);
                            // });
                            editPostBloc.add(ChooseImageEvent(pickedFile: pickedFile));
                            print("pickedFile State");
                            print(state.pickedFile);
                            Navigator.of(context).pop();
                          },
                        ),
                        Padding(padding: EdgeInsets.all(8)),
                        GestureDetector(
                          child: Text("Máy ảnh"),
                          onTap: () async{
                            // _openCamera(context);
                            var pickedFile = await picker.pickImage(
                                source: ImageSource.camera);
                            // this.setState(() {
                            imageFile = File(pickedFile.path);
                            //   print("imageFile ${imageFile}");
                            //   print(pickedFile.path);
                            //   print(pickedFile.name);
                            // });
                            editPostBloc.add(ChooseImageEvent(pickedFile: pickedFile));
                            print("pickedFile State");
                            print(state.pickedFile);
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    );
                  }
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    EditPostBloc _editPostBloc = BlocProvider.of<EditPostBloc>(context);
    return Center(
      child: Container(
        width: 250,
        height: 340,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[200]),
            color: Colors.grey[200]),
        child: BlocBuilder<EditPostBloc, EditPostState>(
            bloc: _editPostBloc,
            builder: (context, state){
              print("image url");
              print(state.postReceive.imagePath);
              String url = state.postReceive.imagePath;
              return Stack(
                children: <Widget>[
                  // Center(
                  //   child: CachedNetworkImage(
                  //     errorWidget: (context, url, error) => Icon(Icons.error),
                  //     placeholder: (context, url) => const CircularProgressIndicator(),
                  //     imageUrl:
                  //     state.postReceive.imagePath,
                  //   ),
                  // ),
                  Center(
                    child: Container(
                        child: imageFile != null
                            ? Image.file(imageFile)
                            : ((url != null) ? Image.network(url) : const Text("No image"))
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: RaisedButton(
                      onPressed: () {
                        _showChoiceDialog(context);
                      },
                      child: Text("Ấn để chọn ảnh", style: TextStyle(color: Colors.black54),),
                    ),
                  )
                ],
              );
            }
        ),
      ),
    );
  }
}
