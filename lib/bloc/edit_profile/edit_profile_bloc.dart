import 'package:congdongchungcu/base_bloc.dart';
import 'package:congdongchungcu/bloc/edit_profile/edit_profile_event.dart';
import 'package:congdongchungcu/bloc/edit_profile/edit_profile_state.dart';
import 'package:congdongchungcu/models/user_model.dart';
import 'package:congdongchungcu/repository/user_repository.dart';
import 'package:congdongchungcu/service/interface/i_edit_profile_service.dart';
import 'package:get_it/get_it.dart';

class EditProfileBloc extends BaseBloc<EditProfileEvent, EditProfileState>{
  final IEditProfileService service;

  EditProfileBloc(this.service) : super(
    EditProfileState(userModelReceive: UserModel(email: "", fullName: "", id: 1, phone: "", username: "", status: true, isSystemAdmin: true, password: ""))
    ){
    on((event, emit) async{
      if(event is UpdateProfileEvent){
        print("event.userModel.phone: ${event.userModel.phone}");
        bool result = await service.updateInfoUser(event.userModel);
        //
        if(result)
        {
          print("Update Thành Công Profile");
          print(event.userModel.id);
          //
          listener.add(NavigateToProfilePageEvent());

          // UserRepository userRepository = GetIt.I.get<UserRepository>().currentUser;
          //
          // emit(state.copyWith(
          //       fullname: userRepository.fullname,
          //       phone: userRepository.phone,
          //       email: userRepository.email,
          //     )
          // );
        }
        else
        {
          print("Update Không Thành Công");
        }
      }
    });
  }

}