import '../../../models/news/get_news_model.dart';
import '../../../models/news/news_model.dart';
import 'package:equatable/equatable.dart';

class NewsManageState extends Equatable{
  final List<NewsModel> currentListNews;
  final GetNewsModel getNewsModel;
  final bool hasNext;

  const NewsManageState({this.currentListNews, this.getNewsModel, this.hasNext});

  NewsManageState copyWith({List<NewsModel> currentListNews, GetNewsModel getNewsModel, bool hasNext}){
    return NewsManageState(
        currentListNews: currentListNews ?? this.currentListNews,
        getNewsModel: getNewsModel ?? this.getNewsModel,
        hasNext: hasNext ?? this.hasNext
    );
  }
  @override
  // TODO: implement props
  List<Object> get props => [currentListNews, getNewsModel, hasNext];
}