import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:congdongchungcu/bloc/post_manage/post_manage_event.dart';
import 'package:congdongchungcu/bloc/post_manage/post_manage_state.dart';
import 'package:congdongchungcu/firebase_utils.dart';
import 'package:congdongchungcu/models/paging_result_model.dart';
import 'package:congdongchungcu/models/posts/get_posts_model.dart';
import 'package:congdongchungcu/models/posts/post_model.dart';
import 'package:congdongchungcu/models/user_model.dart';
import 'package:congdongchungcu/service/interface/i_post_manage_service.dart';
import 'package:congdongchungcu/service/interface/i_posts_service.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../base_bloc.dart';

class PostManageBloc extends BaseBloc<PostManageEvent, PostManageState> {
  final IPostManageService service;

  PostManageBloc(this.service)
      : super(PostManageState(
          currentListPosts: [],
          getPostsModel: GetPostsModel(currPage: 1),
          hasNext: false,
        )) {
    on((event, emit) async {
      if (event is LoadPostManageEvent) {
        PagingResult<PostModel> pagingResult =
            await service.getManagePosts(state.getPostsModel.currPage);
        print("Paging: ${state.getPostsModel.currPage}");
        if (pagingResult != null) {
          List<PostModel> items = pagingResult.items;
          //get user ava
          Map<int, String> ava = {};
          QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('user_image').get();
          for (var element in querySnapshot.docs) {
            int id = int.parse(element.id);
            Map<String, dynamic> dataMap = element.data();
            ava[id] = dataMap['image_path'];
          }

          if (state.currentListPosts.isNotEmpty) {
            for (int i = 0; i < items.length; i++) {
              PostModel item = items[i];
              //get Image Post
              String imageUrl = await FirebaseUtils.getImageUrl("post", item.id);
              if (imageUrl != null) {
                item.imagePath = imageUrl;
              }
              int userId = await service.getUserId(item.residentId);
              UserModel userModel = await service.getUser(userId);
              //get imagePath of userId
              if (userModel != null) {
                String avaPath = ava[userId];
                if (avaPath != null){
                  userModel.avaPath = avaPath;
                } else {
                  userModel.avaPath = "https://iupac.org/wp-content/uploads/2018/05/default-avatar.png";
                }
                item.userModel = userModel;
              }
              //postList.add(post);
              state.currentListPosts.add(item);
            }
            emit(
              state.copyWith(
                  currentListPosts: state.currentListPosts,
                  getPostsModel: state.getPostsModel,
                  hasNext: pagingResult.hasNext),
            );
          } else {
            for (int i = 0; i < items.length; i++) {
              PostModel item = items[i];
              //get Image Post
              String imageUrl = await FirebaseUtils.getImageUrl("post", item.id);
              if (imageUrl != null) {
                item.imagePath = imageUrl;
              }
              int userId = await service.getUserId(item.residentId);
              UserModel userModel = await service.getUser(userId);
              //get imagePath of userId
              if (userModel != null) {
                String avaPath = ava[userId];
                if (avaPath != null){
                  userModel.avaPath = avaPath;
                } else {
                  userModel.avaPath = "https://iupac.org/wp-content/uploads/2018/05/default-avatar.png";
                }
                item.userModel = userModel;
              }
            }
            //state.currentListPosts.addAll(postList);
            emit(
              state.copyWith(
                  currentListPosts: items,
                  getPostsModel: state.getPostsModel,
                  hasNext: pagingResult.hasNext),
            );
          }
        } else {
          emit(
            state.copyWith(
                currentListPosts: <PostModel>[],
                getPostsModel: state.getPostsModel,
                hasNext: false),
          );
        }
      } else if (event is RejectedPostEvent) {
        bool result = await service.rejectedPost(event.postModelRejected);
        if (result) {
          listener.add(RejectedSuccessEvent());
        } else {
          listener.add(RejectedFailEvent());
        }
        if (!result) {
          print("delete k thanh cong");
        }
      } else if (event is ApprovedPostEvent) {
        bool result = await service.approvedPost(event.postModelApproved);
        print("result: ${result}");
        if (result) {
          listener.add(ApprovedSuccessEvent());
        } else {
          listener.add(ApprovedFailEvent());
        }
        if (!result) {
          print("approved thanh cong");
        }
      } else if (event is RefreshPageManagePostEvent) {
        state.getPostsModel.currPage = 1;
        emit(state.copyWith(
            currentListPosts: <PostModel>[],
            getPostsModel: state.getPostsModel,
            hasNext: false));
      } else if (event is IncreaseNewsCurrPageManageEvent) {
        state.getPostsModel.currPage++;
        emit(state.copyWith(getPostsModel: state.getPostsModel));
      }
    });
  }
}
