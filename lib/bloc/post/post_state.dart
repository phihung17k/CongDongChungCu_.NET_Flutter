
import 'package:congdongchungcu/models/posts/get_posts_model.dart';
import 'package:congdongchungcu/models/posts/post_model.dart';
import 'package:equatable/equatable.dart';

class PostState extends Equatable{
  final List<PostModel> currentListPosts;
  final GetPostsModel getPostsModel;
  final bool hasNext;

  PostState({this.currentListPosts, this.getPostsModel, this.hasNext});

  PostState copyWith({List<PostModel> currentListPosts, GetPostsModel getPostsModel, bool hasNext}){
    return PostState(
        currentListPosts: currentListPosts ?? this.currentListPosts,
        getPostsModel: getPostsModel ?? this.getPostsModel,
        hasNext: hasNext ?? this.hasNext
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [currentListPosts, getPostsModel, hasNext];
}