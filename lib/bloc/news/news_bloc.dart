import '../../../repository/user_repository.dart';
import 'package:get_it/get_it.dart';

import '../../../models/news/get_news_model.dart';
import '../../../models/news/news_model.dart';
import '../../../models/paging_result_model.dart';
import '../../../service/interface/i_services.dart';

import '../../base_bloc.dart';
import 'news_event.dart';
import 'news_state.dart';


class NewsBloc extends BaseBloc<NewsEvent, NewsState> {
  final INewsService service;
  UserRepository user = GetIt.I.get<UserRepository>();

  NewsBloc(this.service)
      : super(NewsState(
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
      }
      // else if (event is DetailNewsNavigator){
      //   listener.add(DetailNewsNavigator(detailModel: event.detailModel));
      // }
    });
  }
}
