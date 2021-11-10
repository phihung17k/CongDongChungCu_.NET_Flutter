import '../../../repository/user_repository.dart';
import 'package:get_it/get_it.dart';

import '../../../models/news/get_news_model.dart';
import '../../../models/news/news_model.dart';
import '../../../models/paging_result_model.dart';
import '../../../service/interface/i_services.dart';

import '../../base_bloc.dart';
import 'news_manage_event.dart';
import 'news_manage_state.dart';

class NewsManageBloc extends BaseBloc<NewsManageEvent, NewsManageState> {
  final INewsManageService service;
  UserRepository user = GetIt.I.get<UserRepository>();

  NewsManageBloc(this.service)
      : super(NewsManageState(
            currentListNews: const <NewsModel>[],
            getNewsModel: GetNewsModel(currPage: 1),
            hasNext: false)) {
    on((event, emit) async {
      if (event is GettingAllNewsEvent) {
        int apartmentId = user.selectedResident.apartmentId;
        PagingResult<NewsModel> pagingResult =
            await service.getNewsByCondition(state.getNewsModel, apartmentId);
        List<NewsModel> items = pagingResult.items;
        if (state.currentListNews.isNotEmpty) {
          for (int i = 0; i < items.length; i++) {
            state.currentListNews.add(items[i]);
          }
          emit(state.copyWith(
              currentListNews: state.currentListNews,
              getNewsModel: state.getNewsModel,
              hasNext: pagingResult.hasNext));
        } else {
          emit(state.copyWith(
              currentListNews: items,
              getNewsModel: state.getNewsModel,
              hasNext: pagingResult.hasNext));
        }
      } else if (event is IncreaseNewsCurrPage) {
        state.getNewsModel.currPage++;
        emit(state.copyWith(getNewsModel: state.getNewsModel));
      } else if (event is RefreshNews) {
        state.getNewsModel.currPage = 1;
        emit(state.copyWith(
            currentListNews: <NewsModel>[],
            getNewsModel: state.getNewsModel,
            hasNext: false));
      } else if (event is SaveKeyword) {
        state.getNewsModel.currPage = 1;
        state.getNewsModel.keyword = event.keyword;
        emit(state.copyWith(
            currentListNews: <NewsModel>[],
            getNewsModel: state.getNewsModel,
            hasNext: false));
      } else if (event is SaveDate) {
        state.getNewsModel.currPage = 1;
        state.getNewsModel.fromDate = event.fromDate;
        state.getNewsModel.toDate = event.toDate;
        emit(state.copyWith(
            currentListNews: <NewsModel>[],
            getNewsModel: state.getNewsModel,
            hasNext: false));
      } else if (event is DeleteNews) {
        bool result =
            await service.deleteNews(event.id, user.selectedResident.authToken);
        if (result) {
          listener.add(DeleteSuccess());
        } else {
          listener.add(DeleteFail());
        }
      } else if (event is EditNewsNavigator) {
        listener.add(EditNewsNavigator(editModel: event.editModel));
      } else if (event is CreateNewsNavigator){
        listener.add(CreateNewsNavigator());
      }
      // else if (event is DetailNewsNavigator){
      //   listener.add(DetailNewsNavigator(detailModel: event.detailModel));
      // }
    });
  }
}
