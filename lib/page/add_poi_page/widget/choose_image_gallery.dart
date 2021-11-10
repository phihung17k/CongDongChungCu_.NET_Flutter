import 'dart:io';

import 'package:congdongchungcu/bloc/add_poi/add_poi_bloc.dart';
import 'package:congdongchungcu/bloc/add_poi/add_poi_event.dart';
import 'package:congdongchungcu/bloc/add_poi/add_poi_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ChooseImageInGalleryInAdd extends StatefulWidget {
  @override
  _ChooseImageInGalleryInAddState createState() => _ChooseImageInGalleryInAddState();
}

class _ChooseImageInGalleryInAddState extends State<ChooseImageInGalleryInAdd> {
  File imageFile;
  final picker = ImagePicker();

  // _openGallery(BuildContext context) async {
  //   var pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //   this.setState(() {
  //     imageFile = File(pickedFile.path);
  //   });
  //   Navigator.of(context).pop();
  // }

  // _openCamera(BuildContext context) async {
  //   var pickedFile = await picker.pickImage(source: ImageSource.camera);
  //   this.setState(() {
  //     imageFile = File(pickedFile.path);
  //     print("imageFile ${imageFile}");
  //   });
  //   Navigator.of(context).pop();
  // }

  Future<void> _showChoiceDialog(BuildContext context) {
      AddPOIBloc bloc = BlocProvider.of<AddPOIBloc>(context);
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Make a choice"),
            content: SingleChildScrollView(
              child: BlocBuilder<AddPOIBloc, AddPOIState>(
                bloc: bloc,
                builder: (context, state){
                return ListBody(
                  children: [
                    GestureDetector(
                      child: Text("Gallery"),
                      onTap: () async{
                        // _openGallery(context);
                            var pickedFile = await picker.pickImage(
                                source: ImageSource.gallery);
                            // this.setState(() {
                              imageFile = File(pickedFile.path);
                            // });
                            bloc.add(ChooseImage(pickedFile: pickedFile));
                            print("pickedFile State");
                            print(state.pickedFile);
                            Navigator.of(context).pop();
                      },
                    ),
                    Padding(padding: EdgeInsets.all(8)),
                    GestureDetector(
                      child: Text("Camera"),
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
                            bloc.add(ChooseImage(pickedFile: pickedFile));
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
        width: 250,
        height: 340,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[200]),
            color: Colors.grey[200]),
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                child: imageFile != null
                    ? Image.file(imageFile)
                    : Text("Chưa có hình"),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: RaisedButton(
                onPressed: () {
                  _showChoiceDialog(context);
                },
                child: Text("Tải hình lên"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
