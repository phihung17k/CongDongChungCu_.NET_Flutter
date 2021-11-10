
import 'package:congdongchungcu/models/comment/comment_model.dart';

class CommentEvent{}

class LoadCommentEvent extends CommentEvent {
  final int postId;
  LoadCommentEvent({this.postId});
}

class AddNewCommentEvent extends CommentEvent {
  final String content;
  final int postId;
  AddNewCommentEvent({this.content,  this.postId});
}

class GetCommentContentEvent extends CommentEvent {
  final String content;
  GetCommentContentEvent({this.content});
}

class GetPostIdEvent extends CommentEvent {
  final int postId;
  GetPostIdEvent({this.postId});
}

class NavigatorEditCommentEvent extends CommentEvent {
  final CommentModel commentModel;
  NavigatorEditCommentEvent({this.commentModel});
}

class DeleteCommentEvent extends CommentEvent {
  final int commentId;
  final int ownerCommentId;
  DeleteCommentEvent({this.commentId, this.ownerCommentId});
}

class AddCommentSuccessEvent extends CommentEvent{
  // final bool isCreated;
  // AddCommentSuccessEvent(this.isCreated);
}

class AddCommentFailEvent extends CommentEvent{}

class DeleteSuccessCommentEvent extends CommentEvent{}
class DeleteFailCommentEvent extends CommentEvent{}

class RefreshPageCommentEvent extends CommentEvent{}
class IncreaseNewsCurrPageCommentEvent extends CommentEvent{}