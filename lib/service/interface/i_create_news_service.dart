import '../../models/news/news_model.dart';

abstract class ICreateNewsService{
  Future<bool> createNews(NewsModel model, String authToken, int apartmentId);
}