import 'package:get_it/get_it.dart';

import '../../repository/user_repository.dart';

import '../../service/interface/i_services.dart';

import '../../base_bloc.dart';
import 'create_news_event.dart';
import 'create_news_state.dart';

class CreateNewsBloc
    extends BaseBloc<CreateNewsEvent, CreateNewsState> {
  final ICreateNewsService service;
  UserRepository user = GetIt.I.get<UserRepository>();

  CreateNewsBloc(this.service)
      : super(const CreateNewsState()) {
    on((event, emit) async {
      if (event is SaveNews) {
        bool result = await service.
        createNews(event.createModel, user.selectedResident.authToken,
            user.selectedResident.apartmentId);
        if (result){
          listener.add(CreateSuccess());
        } else {
          listener.add(CreateFail());
        }
      }
      });
  }
}
