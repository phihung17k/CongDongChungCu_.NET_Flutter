import '../../models/news/news_model.dart';

class CreateNewsEvent{}
class SaveNews extends CreateNewsEvent{
  final NewsModel createModel;
  SaveNews(this.createModel);
}
class CreateSuccess extends CreateNewsEvent{}
class CreateFail extends CreateNewsEvent{}