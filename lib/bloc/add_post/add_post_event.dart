import 'package:image_picker/image_picker.dart';

class AddPostEvent {}

class AddNewPostEvent extends AddPostEvent{
  final String title;
  final String content;

  AddNewPostEvent({this.title, this.content});
}

class GetPostTitleEvent extends AddPostEvent {
    final String title;
    GetPostTitleEvent({this.title});
}

class GetPostContentEvent extends AddPostEvent {
  final String content;
  GetPostContentEvent({this.content});
}

class ChooseImage extends AddPostEvent{
  final XFile pickedFile;
  ChooseImage({this.pickedFile});
}

class AddPostSuccessEvent extends AddPostEvent{
  final int id;
  AddPostSuccessEvent(this.id);
}
class AddPostFailEvent extends AddPostEvent{}

// class GetPostResidentIdEvent extends AddPostEvent {
//   final int residentId;
//   GetPostResidentIdEvent({this.residentId});
// }