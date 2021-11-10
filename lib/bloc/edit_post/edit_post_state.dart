import 'package:congdongchungcu/models/posts/post_model.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class EditPostState extends Equatable{
  PostModel postReceive;
  final XFile pickedFile;

  EditPostState({this.postReceive, this.pickedFile});

  EditPostState copyWith({PostModel postReceive, XFile pickedFile}){
    return EditPostState(
        postReceive: postReceive ?? this.postReceive,
        pickedFile: pickedFile ?? this.pickedFile,
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [postReceive, pickedFile];
}