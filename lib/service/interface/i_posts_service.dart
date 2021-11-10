import 'package:congdongchungcu/models/enum.dart';
import 'package:congdongchungcu/models/paging_result_model.dart';
import 'package:congdongchungcu/models/posts/get_posts_model.dart';
import 'package:congdongchungcu/models/posts/post_model.dart';
import 'package:congdongchungcu/models/resident_model.dart';
import 'package:congdongchungcu/models/user_model.dart';

abstract class IPostService{
  Future<PagingResult<PostModel>> getPosts(int currentPage);

  Future<int> getUserId(int residentId);

  Future<UserModel> getUser(int userId);

  Future<bool> deletePost(PostModel deletePost);
}