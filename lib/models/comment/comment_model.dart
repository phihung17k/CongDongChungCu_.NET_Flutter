import 'package:intl/intl.dart';

import '../user_model.dart';

class CommentModel {
  int commentId;
  String content;
  String createdTime;
  int postId;
  int residentId;
  UserModel userModel;
  String ownerComment;

  CommentModel(
      {this.commentId,
      this.content,
      this.createdTime,
      this.postId,
      this.residentId,
      this.userModel,
      this.ownerComment});

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    if (json == null) throw Exception("Json posts model cannot null");
    int commentId = json['id'];
    String content = json['content'];
    String createdTime = DateFormat('dd-MM-yyyy HH:mm')
        .format(DateTime.parse(json['created_time']));
    int postId = json['post_id'];
    int residentId = json['resident_id'];
    String ownerComment = json['owner_name_comment'];
    return CommentModel(
      commentId: commentId,
      content: content,
      createdTime: createdTime,
      postId: postId,
      residentId: residentId,
      ownerComment: ownerComment,
    );
  }

  static CommentModel fromJsonModel(Map<String, dynamic> json) =>
      CommentModel.fromJson(json);
}
