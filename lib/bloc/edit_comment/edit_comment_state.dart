import 'package:congdongchungcu/models/comment/comment_model.dart';
import 'package:equatable/equatable.dart';

class EditCommentState extends Equatable{
  final CommentModel commentReceive;

  EditCommentState({this.commentReceive});

  EditCommentState copyWith({CommentModel commentReceive}){
    return EditCommentState(
      commentReceive: commentReceive ?? this.commentReceive
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [commentReceive];
}