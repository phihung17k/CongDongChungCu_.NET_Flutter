import 'package:congdongchungcu/models/comment/comment_model.dart';
import 'package:congdongchungcu/models/posts/post_model.dart';

abstract class IEditCommentService {
  Future<bool> updateCommentByID(CommentModel commentModelUpdate);
}