import 'package:congdongchungcu/models/posts/post_model.dart';

abstract class IEditPostService {
  Future<bool> updatePostByID(PostModel postUpdate);
}