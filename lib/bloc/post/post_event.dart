
import 'package:congdongchungcu/models/enum.dart';
import 'package:congdongchungcu/models/posts/get_posts_model.dart';
import 'package:congdongchungcu/models/posts/post_model.dart';

class PostEvent{}

class LoadPostEvent extends PostEvent {
  // GetPostsModel model;
  // LoadPostPageEvent({this.model});
  final int currentPage;

  LoadPostEvent({this.currentPage});
}

class SelectingPostEvent extends PostEvent {
  // final PostModel postModel;
  //
  // SelectingPostEvent({this.postModel});
}

class NavigatorAddPostEvent extends PostEvent {
  // final PostModel postModel;
  // NavigatorAddPostEvent({this.postModel});
}

class NavigatorEditPostEvent extends PostEvent {
  final PostModel postModel;
  NavigatorEditPostEvent({this.postModel});
}

class DeletePostEvent extends PostEvent{
  final PostModel postModelDelete;
  DeletePostEvent({this.postModelDelete});
}

class DeleteSuccessEvent extends PostEvent{}
class DeleteFailEvent extends PostEvent{}

class RefreshPageEvent extends PostEvent{}
class IncreaseNewsCurrPageEvent extends PostEvent{}

// class IncreasePostsCurrPage extends PostEvent{}
// class RefreshPosts extends PostEvent{}