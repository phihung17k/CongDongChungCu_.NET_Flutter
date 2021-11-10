import 'dart:io';

import 'package:congdongchungcu/bloc/edit_poi/edit_poi_bloc.dart';
import 'package:congdongchungcu/bloc/edit_poi/edit_poi_event.dart';
import 'package:congdongchungcu/bloc/edit_poi/edit_poi_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ChooseImageInGallery extends StatefulWidget {
  @override
  _ChooseImageInGalleryState createState() => _ChooseImageInGalleryState();
}

class _ChooseImageInGalleryState extends State<ChooseImageInGallery> {
  File imageFile;
  final picker = ImagePicker();

  Future<void> _showChoiceDialog(BuildContext context) {
    EditPOIBloc bloc = BlocProvider.of<EditPOIBloc>(context);
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Make a choice"),
            content: SingleChildScrollView(
              child: BlocBuilder<EditPOIBloc, EditPOIState>(
                  bloc: bloc,
                  builder: (context, state) {
                    return ListBody(
                      children: [
                        GestureDetector(
                          child: Text("Thư viện"),
                          onTap: () async {
                            var pickedFile = await picker.pickImage(
                                source: ImageSource.gallery);
                              imageFile = File(pickedFile.path);
                            bloc.add(ChooseImage(pickedFile: pickedFile));
                            print("pickedFile State");
                            print(state.pickedFile);
                            Navigator.of(context).pop();
                          },
                        ),
                        Padding(padding: EdgeInsets.all(8)),
                        GestureDetector(
                          child: Text("Camera"),
                          onTap: () async {
                            var pickedFile = await picker.pickImage(
                                source: ImageSource.camera);
                            imageFile = File(pickedFile.path);
                            bloc.add(ChooseImage(pickedFile: pickedFile));
                            print("pickedFile State");
                            print(state.pickedFile);
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    );
                  }),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
      EditPOIBloc bloc = BlocProvider.of<EditPOIBloc>(context);
    return Center(
      child: Container(
        width: 250,
        height: 340,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[200]),
            color: Colors.grey[200]),
        child: BlocBuilder<EditPOIBloc, EditPOIState>(
          bloc: bloc,
          builder: (context, state){
            print("image url");
            print(state.poiReceive.imagePath);
            String url = state.poiReceive.imagePath;
          return Stack(
            children: <Widget>[
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
                  child: Text("Tải hình lên"),
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
