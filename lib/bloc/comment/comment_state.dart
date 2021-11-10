
import 'package:congdongchungcu/models/comment/comment_model.dart';
import 'package:congdongchungcu/models/comment/get_comments_model.dart';
import 'package:equatable/equatable.dart';

class CommentState extends Equatable{
  final List<CommentModel> currentListComments;
   final GetCommentModel getCommentModel;
   final bool hasNext;
  final String content;
  final int postId;
  final bool isFirst;
  final bool isChanged;

  CommentState({this.isFirst, this.currentListComments, this.content, this.postId, this.hasNext, this.getCommentModel, this.isChanged});

  CommentState copyWith({bool isFirst, List<CommentModel> currentListComments, String content, int postId, GetCommentModel getCommentModel, bool hasNext, bool isChanged}){
    return CommentState(
        currentListComments: currentListComments ?? this.currentListComments,
        getCommentModel: getCommentModel ?? this.getCommentModel,
        hasNext: hasNext ?? this.hasNext,
      content: content ?? this.content,
      postId: postId ?? this.postId,
      isFirst: isFirst ?? this.isFirst,
      isChanged: isChanged ?? this.isChanged
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [isFirst, currentListComments, content, postId, getCommentModel, hasNext, isChanged];
}