import 'dart:io';

import 'package:congdongchungcu/bloc/add_post/add_post_bloc.dart';
import 'package:congdongchungcu/bloc/add_post/add_post_event.dart';
import 'package:congdongchungcu/bloc/add_post/add_post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ChooseImageInGalleryToAdd extends StatefulWidget {
  @override
  _ChooseImageInGalleryToAddState createState() => _ChooseImageInGalleryToAddState();
}

class _ChooseImageInGalleryToAddState extends State<ChooseImageInGalleryToAdd> {
  File imageFile;
  final picker = ImagePicker();

  Future<void> _showChoiceDialog(BuildContext context) {
    AddPostBloc addPostBloc = BlocProvider.of<AddPostBloc>(context);
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Chọn ảnh từ"),
            content: SingleChildScrollView(
              child: BlocBuilder<AddPostBloc, AddPostState>(
                  bloc: addPostBloc,
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
                            addPostBloc.add(ChooseImage(pickedFile: pickedFile));
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
                            addPostBloc.add(ChooseImage(pickedFile: pickedFile));
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
    return Center(
      child: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[200]),
            color: Colors.grey[200]),
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                child: imageFile != null
                    ? Image.file(imageFile)
                    : Text("Chưa chọn ảnh"),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: RaisedButton(
                onPressed: () {
                  _showChoiceDialog(context);
                },
                child: Text("Ấn để chọn ảnh", style: TextStyle(color: Colors.black54)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
