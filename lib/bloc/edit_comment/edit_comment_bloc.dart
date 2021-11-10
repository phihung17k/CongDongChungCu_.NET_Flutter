import 'package:congdongchungcu/base_bloc.dart';
import 'package:congdongchungcu/bloc/edit_comment/edit_comment_event.dart';
import 'package:congdongchungcu/bloc/edit_comment/edit_comment_state.dart';
import 'package:congdongchungcu/models/comment/comment_model.dart';
import 'package:congdongchungcu/service/interface/i_edit_comment_service.dart';


class EditCommentBloc extends BaseBloc<EditCommentEvent, EditCommentState>{
  final IEditCommentService service;

  EditCommentBloc(this.service) : super(EditCommentState(commentReceive: CommentModel(postId: 1, content: "", residentId: 1, ownerComment: "", createdTime: null, commentId: 1))){
    on((event, emit) async{
      if(event is ReceiveDataFromCommentPage){
        emit(
            state.copyWith(commentReceive: event.commentReceive)
        );
      }
       else if (event is UpdateCommentEvent) {
        bool result = await service.updateCommentByID(event.commentModelUpdate);
        if (result) {
          listener.add(UpdateCommmentSuccessEvent(event.commentModelUpdate.commentId));
        } else {
          listener.add(UpdateCommentFailEvent());
        }
        print("check update status: ${result}");
        if (!result) {
          print("update khong thanh cong");
        }
      }
    });
  }

}