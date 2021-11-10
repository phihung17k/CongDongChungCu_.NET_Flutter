import 'package:congdongchungcu/models/posts/post_model.dart';

class PostManageEvent {}

class LoadPostManageEvent extends PostManageEvent {
// GetPostsModel model;
// LoadPostPageEvent({this.model});
final int currentPage;

LoadPostManageEvent({this.currentPage});
}

class RejectedPostEvent extends PostManageEvent{
  final PostModel postModelRejected;
  RejectedPostEvent({this.postModelRejected});
}

class ApprovedPostEvent extends PostManageEvent{
  final PostModel postModelApproved;
  ApprovedPostEvent({this.postModelApproved});
}

class RejectedSuccessEvent extends PostManageEvent{}
class RejectedFailEvent extends PostManageEvent{}

class ApprovedSuccessEvent extends PostManageEvent{}
class ApprovedFailEvent extends PostManageEvent{}

class RefreshPageManagePostEvent extends PostManageEvent{}
class IncreaseNewsCurrPageManageEvent extends PostManageEvent{}