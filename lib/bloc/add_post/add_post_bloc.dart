import 'package:congdongchungcu/bloc/add_post/add_post_event.dart';
import 'package:congdongchungcu/bloc/add_post/add_post_state.dart';
import 'package:congdongchungcu/service/interface/i_add_post_service.dart';
import 'package:image_picker/image_picker.dart';

import '../../base_bloc.dart';
import '../../firebase_utils.dart';

class AddPostBloc extends BaseBloc<AddPostEvent, AddPostState> {
  final IAddPostService service;

  AddPostBloc(this.service) : super(AddPostState(pickedFile: XFile(""))) {
    on((event, emit) async {
      if (event is GetPostTitleEvent) {
        emit(state.copyWith(title: event.title));
      }
      if (event is GetPostContentEvent) {
        emit(state.copyWith(content: event.content));
      }
      // if (event is GetPostResidentIdEvent) {
      //   emit(state.copyWith(residentId: event.residentId));
      // }
      if (event is AddNewPostEvent) {
       int id = await service.addPost(event.title, event.content);
       print("idAddBloc: ${id}");
        if (id > 0) {
          await FirebaseUtils.uploadFile(state.pickedFile.path, id.toString(),"post");
            listener.add(AddPostSuccessEvent(id));
          } else {
          listener.add(AddPostFailEvent());
        }
      }
      if(event is ChooseImage){
        emit(state.copyWith(pickedFile: event.pickedFile));
      }
    });
  }
}
