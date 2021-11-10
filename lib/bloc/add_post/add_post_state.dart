import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class AddPostState extends Equatable {
  final String title;
  final String content;
  final int residentId;
  final XFile pickedFile;

  AddPostState({this.pickedFile, this.title, this.content, this.residentId});

  AddPostState copyWith({String title, String content, int residentId, XFile pickedFile}) {
    return AddPostState(
        title: title ?? this.title,
        content: content ?? this.content,
        residentId: residentId ?? this.residentId,
        pickedFile: pickedFile ?? this.pickedFile,
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [title, content, residentId, pickedFile];
}
