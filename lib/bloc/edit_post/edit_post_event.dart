import 'package:congdongchungcu/models/posts/post_model.dart';
import 'package:image_picker/image_picker.dart';

class EditPostEvent {}

class ReceiveDataFromCommunityPage extends EditPostEvent {
  final PostModel postReceive;

  ReceiveDataFromCommunityPage(this.postReceive);
}

class UpdatePostEvent extends EditPostEvent {
  final PostModel postUpdate;
  UpdatePostEvent({this.postUpdate});
}

class UploadFileImageToFireBaseEvent extends EditPostEvent{
  final XFile pickedFile;
  UploadFileImageToFireBaseEvent({this.pickedFile});
}
class ChooseImageEvent extends EditPostEvent{
  final XFile pickedFile;
  ChooseImageEvent({this.pickedFile});
}

class UpdatePostSuccessEvent extends EditPostEvent{
  final int id;
  UpdatePostSuccessEvent(this.id);
}
class UpdatePostFailEvent extends EditPostEvent{}