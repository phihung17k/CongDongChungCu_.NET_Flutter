import 'package:congdongchungcu/models/enum.dart';
import 'package:congdongchungcu/models/paging_result_model.dart';
import 'package:congdongchungcu/models/posts/get_posts_model.dart';
import 'package:congdongchungcu/models/posts/post_model.dart';
import 'package:congdongchungcu/models/resident_model.dart';
import 'package:congdongchungcu/models/user_model.dart';

abstract class IPostManageService{
  Future<PagingResult<PostModel>> getManagePosts(int currentPage);

  Future<int> getUserId(int residentId);

  Future<UserModel> getUser(int userId);

  Future<bool> rejectedPost(PostModel rejectedPost);

  Future<bool> approvedPost(PostModel approvedPost);
}