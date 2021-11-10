import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChooseImageInGallery extends StatefulWidget {
  @override
  _ChooseImageInGalleryState createState() => _ChooseImageInGalleryState();
}

class _ChooseImageInGalleryState extends State<ChooseImageInGallery> {
  File imageFile;
  final picker = ImagePicker();

  _openGallery(BuildContext context) async {
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = File(pickedFile.path);
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var pickedFile = await picker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = File(pickedFile.path);
      print("imageFile ${imageFile}");
    });
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Make a choice"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("Gallery"),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8)),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      _openCamera(context);
                    },
                  )
                ],
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
                    : Text("No image selected"),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: RaisedButton(
                onPressed: () {
                  _showChoiceDialog(context);
                },
                child: Text("Select Image"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
