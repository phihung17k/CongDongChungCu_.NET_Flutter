import '../../../models/news/get_news_model.dart';
import '../../../models/news/news_model.dart';
import 'package:equatable/equatable.dart';

class NewsState extends Equatable{
  final List<NewsModel> currentListNews;
  final GetNewsModel getNewsModel;
  final bool hasNext;

  const NewsState({this.currentListNews, this.getNewsModel, this.hasNext});

  NewsState copyWith({List<NewsModel> currentListNews, GetNewsModel getNewsModel, bool hasNext}){
    return NewsState(
        currentListNews: currentListNews ?? this.currentListNews,
        getNewsModel: getNewsModel ?? this.getNewsModel,
        hasNext: hasNext ?? this.hasNext
    );
  }
  @override
  // TODO: implement props
  List<Object> get props => [currentListNews, getNewsModel, hasNext];
}