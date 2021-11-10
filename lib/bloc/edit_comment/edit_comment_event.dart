import 'package:congdongchungcu/models/comment/comment_model.dart';

class EditCommentEvent {}

class ReceiveDataFromCommentPage extends EditCommentEvent {
  final CommentModel commentReceive;

  ReceiveDataFromCommentPage({this.commentReceive});
}

class UpdateCommentEvent extends EditCommentEvent {
  final CommentModel commentModelUpdate;
  UpdateCommentEvent({this.commentModelUpdate});
}

class UpdateCommmentSuccessEvent extends EditCommentEvent{
  final int id;
  UpdateCommmentSuccessEvent(this.id);
}
class UpdateCommentFailEvent extends EditCommentEvent{}