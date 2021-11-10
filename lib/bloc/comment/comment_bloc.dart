import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:congdongchungcu/bloc/comment/comment_event.dart';
import 'package:congdongchungcu/bloc/comment/comment_state.dart';
import 'package:congdongchungcu/models/comment/comment_model.dart';
import 'package:congdongchungcu/models/comment/get_comments_model.dart';
import 'package:congdongchungcu/models/paging_result_model.dart';
import 'package:congdongchungcu/models/user_model.dart';

import '/service/services.dart';
import '../../base_bloc.dart';

class CommentBloc extends BaseBloc<CommentEvent, CommentState> {
  final ICommentService service;

  //đưa init state vào cho bloc
  CommentBloc(this.service)
      : super(CommentState(
          isFirst: true,
          currentListComments: [],
          content: "",
          postId: 0,
          getCommentModel: GetCommentModel(currPage: 1),
          hasNext: false,
          isChanged: false,
        )) {
    on((event, emit) async {
      if (event is GetCommentContentEvent) {
        emit(state.copyWith(content: event.content));
      }
      if (event is LoadCommentEvent) {
        // int postId;
        // if (event.postId == null) {
        //   postId = state.postId;
        //   print("postIdNull: ${postId}");
        // } else {
        //   postId = event.postId;
        //   print("postId: ${postId}");
        // }
        // int postId = event.postId;
        // if (postId == null) {
        //   postId = state.postId;
        // }
        print("current page " + state.getCommentModel.currPage.toString());
        PagingResult<CommentModel> pagingResult = await service.getComments(
            state.postId, state.getCommentModel.currPage);
        // print("Paging: ${pagingResult.items}");
        print("paging: ${state.getCommentModel.currPage}");
        print('PagingResultCom: ${pagingResult}');
        if (pagingResult != null) {
          //get avatar from FireStore
          Map<int, String> ava = {};
          QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('user_image').get();
          for (var element in querySnapshot.docs) {
            int id = int.parse(element.id);
            Map<String, dynamic> dataMap = element.data();
            ava[id] = dataMap['image_path'];
          }
          List<CommentModel> commentList = [];
          List<CommentModel> items = pagingResult.items;
          // if (items.isNotEmpty) {
          //   List<CommentModel> listComment = [];
          //   // for (int i = 0; i < items.length; i++) {
          //   //   CommentModel item = items[i];
          //   //   state.currentListComments.add(item);
          //   // }
          //   listComment.addAll(state.currentListComments);
          //   listComment.addAll(items);
          //   emit(state.copyWith(
          //     currentListComments: listComment,
          //     getCommentModel: state.getCommentModel,
          //     hasNext: false,
          //     postId: postId,
          //   ));
          // }
          // print(
          //     "listCommentIsNotEmptyCheck: ${state.currentListComments.isNotEmpty}");
          // if (state.currentListComments.isNotEmpty) {
            // print("listCommentIsNotEmpty: ${state.currentListComments}");
            for (int i = 0; i < items.length; i++) {
              CommentModel item = items[i];
              int userId = await service.getUserId(item.residentId);
              UserModel userModel = await service.getUser(userId);
              print("user model " + userModel.toString());
              
               if(userModel != null){
                 String avaPath1 = "";
               avaPath1 = ava[userId];
               if (avaPath1 != null){
                userModel.avaPath = avaPath1;
              } else {
                userModel.avaPath = "https://iupac.org/wp-content/uploads/2018/05/default-avatar.png";
              }
              item.userModel = userModel;
               }
              
              commentList.add(item);
            }
             
          state.currentListComments.addAll(commentList);
            emit(
              state.copyWith(
                  // postId: state.postId,
                  isFirst: false,
                  currentListComments: state.currentListComments,
                  getCommentModel: state.getCommentModel,
                  hasNext: pagingResult.hasNext,
                  isChanged: !state.isChanged),
            );
          // } else {
          //   print("listCurrentCommentEmpty");
          //   emit(state.copyWith(
          //       // postId: state.postId,
          //       isFirst: false,
          //       currentListComments: items,
          //       hasNext: pagingResult.hasNext,
          //       getCommentModel: state.getCommentModel));
          // }
        } else {
          print("pagingREsultNull");
          emit(state.copyWith(
            // postId: state.postId,
            currentListComments: <CommentModel>[],
            getCommentModel: state.getCommentModel,
            hasNext: false,
          ));
        }
        //print("ElseDataPaging: ${state.currentListComments}");
      }

      // if (event is LoadCommentEvent) {
      //   int postId = event.postId;
      //   List<CommentModel> commentList;
      //   PagingResult<CommentModel> result = await service.getComments(postId);
      //   if (result != null && result.items.isNotEmpty) {
      //     commentList = result.items;
      //   }
      //   print("commentListBloc: ${commentList}");
      //   emit(state.copyWith(
      //     currentListComments: commentList,
      //     getCommentModel: state.getCommentModel,
      //     hasNext: false,
      //     postId: postId,
      //   ));
      // }
      else if (event is AddNewCommentEvent) {
        bool isCreated = await service.addComment(event.content, event.postId);
        print("addCheck: ${isCreated}");
        if (isCreated) {
          listener.add(AddCommentSuccessEvent());
        } else {
          listener.add(AddCommentFailEvent());
        }
      } else if (event is GetPostIdEvent) {
        emit(state.copyWith(postId: event.postId));
      } else if (event is NavigatorEditCommentEvent) {
        listener
            .add(NavigatorEditCommentEvent(commentModel: event.commentModel));
      } else if (event is DeleteCommentEvent) {
        bool result =
            await service.deleteComment(event.commentId, event.ownerCommentId);
        if (result) {
          listener.add(DeleteSuccessCommentEvent());
        } else {
          listener.add(DeleteFailCommentEvent());
        }
      } else if (event is RefreshPageCommentEvent) {
        state.getCommentModel.currPage = 1;
        emit(state.copyWith(
            postId: state.postId,
            currentListComments: <CommentModel>[],
            getCommentModel: state.getCommentModel,
            hasNext: false));
      } else if (event is IncreaseNewsCurrPageCommentEvent) {
        state.getCommentModel.currPage++;
        emit(state.copyWith(getCommentModel: state.getCommentModel));
      }
    });
  }
}
