import '../../service/interface/i_services.dart';

import '../../../repository/user_repository.dart';
import 'package:get_it/get_it.dart';

import '../../../models/news/news_model.dart';

import '../../base_bloc.dart';
import 'edit_news_event.dart';
import 'edit_news_state.dart';


class EditNewsBloc
    extends BaseBloc<EditNewsEvent, EditNewsState> {
  final IEditNewsService service;
  UserRepository user = GetIt.I.get<UserRepository>();

  EditNewsBloc(this.service)
      : super(EditNewsState(receiveModel: NewsModel(), result: false)) {
    on((event, emit) async {
      if (event is ReceiveDataFromNewsPage){
        emit(state.copyWith(receiveModel: event.receiveModel));
      } else if (event is UpdateNews){
        bool result = await service.updateNews(event.updateModel, user.selectedResident.authToken);
        if (result) {
          listener.add(UpdateSuccess(event.updateModel));
        } else {
          listener.add(UpdateFail());
        }
        // emit(state.copyWith(result: result));
      } else if (event is UpdateSuccess){

      }
    });
  }
}
