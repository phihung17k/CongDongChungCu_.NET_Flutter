import 'package:congdongchungcu/base_bloc.dart';
import 'package:congdongchungcu/bloc/edit_post/edit_post_event.dart';
import 'package:congdongchungcu/bloc/edit_post/edit_post_state.dart';
import 'package:congdongchungcu/models/enum.dart';
import 'package:congdongchungcu/models/posts/post_model.dart';
import 'package:congdongchungcu/service/interface/i_edit_post_service.dart';
import 'package:image_picker/image_picker.dart';

import '../../firebase_utils.dart';

class EditPostBloc extends BaseBloc<EditPostEvent, EditPostState>{
  final IEditPostService service;

  EditPostBloc(this.service) : super(EditPostState(postReceive: PostModel(id: 2, title: '', content: '', createdDate: '', status: Status.Approved), pickedFile: XFile(""))){
    on((event, emit) async{
      if(event is ReceiveDataFromCommunityPage){
        emit(
            state.copyWith(postReceive: event.postReceive)
        );
      }

      if (event is UpdatePostEvent) {
        bool result = await service.updatePostByID(event.postUpdate);
        int id = event.postUpdate.id;
        print("id: ${id}");
        if (result) {
          await FirebaseUtils.uploadFile(state.pickedFile.path, event.postUpdate.id.toString(),"post");
          listener.add(UpdatePostSuccessEvent(event.postUpdate.id));
        } else {
          listener.add(UpdatePostFailEvent());
        }
        print("check update status: ${result}");
        if (!result) {
          print("update khong thanh cong");
        }
      }

      if(event is ChooseImageEvent){
        emit(state.copyWith(pickedFile: event.pickedFile));
      }

      if(event is UploadFileImageToFireBaseEvent){
        String imageName = (state.postReceive.id).toString();
        await FirebaseUtils.uploadFile(state.pickedFile.path, imageName,"post");
      }
    });
  }

}