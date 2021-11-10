import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:congdongchungcu/firebase_utils.dart';
import 'package:congdongchungcu/models/paging_result_model.dart';
import 'package:congdongchungcu/models/posts/get_posts_model.dart';
import 'package:congdongchungcu/models/posts/post_model.dart';
import 'package:congdongchungcu/models/resident_model.dart';
import 'package:congdongchungcu/models/user_model.dart';
import 'package:congdongchungcu/service/interface/i_posts_service.dart';

import './post_event.dart';
import './post_state.dart';

import '../../base_bloc.dart';

class PostBloc extends BaseBloc<PostEvent, PostState> {
  final IPostService service;

  PostBloc(this.service)
      : super(PostState(
          currentListPosts: [],
          getPostsModel: GetPostsModel(currPage: 1),
          hasNext: false,
        )) {
    on((event, emit) async {

      if (event is LoadPostEvent) {
        PagingResult<PostModel> result =
            await service.getPosts(state.getPostsModel.currPage);
        if (result != null && result.items.isNotEmpty) {
          //get avatar from FireStore
          Map<int, String> ava = {};
          QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('user_image').get();
          for (var element in querySnapshot.docs) {
            int id = int.parse(element.id);
            Map<String, dynamic> dataMap = element.data();
            ava[id] = dataMap['image_path'];
          }

          List<PostModel> postList = [];
          for (int i = 0; i < result.items.length; i++) {
            PostModel post = result.items[i];
            //get Image Post
            String imageUrl = await FirebaseUtils.getImageUrl("post", post.id);
            if (imageUrl != null) {
              post.imagePath = imageUrl;
            }
            int userId = await service.getUserId(post.residentId);
            UserModel userModel = await service.getUser(userId);
            //get imagePath of userId
            if (userModel != null) {
              String avaPath = ava[userId];
              if (avaPath != null){
                userModel.avaPath = avaPath;
              } else {
                userModel.avaPath = "https://iupac.org/wp-content/uploads/2018/05/default-avatar.png";
              }
              post.userModel = userModel;
              postList.add(post);
            }
          }

          state.currentListPosts.addAll(postList);
          emit(
            state.copyWith(
                currentListPosts: state.currentListPosts,
                //getPostsModel:  state.getPostsModel,
                hasNext: result.hasNext),
          );
        }
      } else if (event is IncreaseNewsCurrPageEvent) {
        state.getPostsModel.currPage++;
        emit(state.copyWith(getPostsModel: state.getPostsModel));
      }
      else if (event is SelectingPostEvent) {
        listener.add(event);
      } else if (event is RefreshPageEvent) {
        state.getPostsModel.currPage = 1;
        emit(state.copyWith(
            currentListPosts: <PostModel>[],
            getPostsModel: state.getPostsModel,
            hasNext: false));
      } else if (event is DeletePostEvent) {
        bool result = await service.deletePost(event.postModelDelete);
        if (result) {
          listener.add(DeleteSuccessEvent());
        } else {
          listener.add(DeleteFailEvent());
        }
        print(result);
        if (!result) {
          print("delete k thanh cong");
        }
      }

      if (event is NavigatorEditPostEvent) {
        listener.add(NavigatorEditPostEvent(postModel: event.postModel));
      }
    });
  }
}
