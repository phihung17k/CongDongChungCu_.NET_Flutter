import 'package:congdongchungcu/models/comment/comment_model.dart';
import 'package:congdongchungcu/models/paging_result_model.dart';
import 'package:congdongchungcu/models/user_model.dart';

abstract class ICommentService{
  Future<PagingResult<CommentModel>> getComments(int postId, int currentPage);
  Future<bool> addComment(String content, int postId);
  Future<bool> deleteComment(int commentId, int ownerCommentId);
  Future<int> getUserId(int residentId);
  Future<UserModel> getUser(int userId);
}