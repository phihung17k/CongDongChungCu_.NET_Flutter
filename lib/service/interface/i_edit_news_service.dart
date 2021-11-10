import '../../models/news/news_model.dart';

abstract class IEditNewsService{
  Future<bool> updateNews(NewsModel model, String authToken);
}