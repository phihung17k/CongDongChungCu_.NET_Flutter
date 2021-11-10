import 'package:congdongchungcu/bloc/profile/profile_event.dart';
import 'package:congdongchungcu/bloc/profile/profile_state.dart';
import 'package:congdongchungcu/models/store_model/get_store_codition.dart';
import 'package:congdongchungcu/models/storedto_model.dart';
import 'package:congdongchungcu/repository/user_repository.dart';
import 'package:congdongchungcu/service/interface/i_profile_service.dart';
import 'package:get_it/get_it.dart';

import '../../base_bloc.dart';

class ProfileBloc extends BaseBloc<ProfileEvent, ProfileState> {
  final IProfileService service;

  ProfileBloc(this.service)
      : super(ProfileState(fullname: "", email: "", phone: "")) {
    on((event, emit) async {
      if (event is LogoutEvent) {
        listener.add(LogoutEvent());
      }

      if (event is AutoLoadProfileEvent) {
        print("AutoLoadProfileEvent is running ...");
        UserRepository user = GetIt.I.get<UserRepository>().currentUser;
        print("phone: ${user.phone}");
        emit(state.copyWith(
            fullname: user.fullname, email: user.email, phone: user.phone));
      }

      if (event is NavigatorToMyShopEvent) {
        int residentId = GetIt.I.get<UserRepository>().selectedResident.id;

        print("residentId: ${residentId}");

        StoreDTO dto = await service
            .getStoreByCondition(GetStoreCondition(residentId: residentId));
        // print("dtoaaaaaaaaaaa ${dto.storeId}");
        if (dto != null) {
          print("Store Id Bloc : " + dto.storeId.toString());
          listener.add(SendStoreIdToMyShopEvent(storeId: dto.storeId));
        } else {
          listener.add(SendStoreIdToMyShopEvent(storeId: 0));
        }
      }
    });
  }
}
