
import '../../models/news/news_model.dart';

class EditNewsEvent{}
class ReceiveDataFromNewsPage extends EditNewsEvent{
  final NewsModel receiveModel;
  ReceiveDataFromNewsPage(this.receiveModel);
}
class UpdateNews extends EditNewsEvent{
  final NewsModel updateModel;
  UpdateNews(this.updateModel);
}
class UpdateSuccess extends EditNewsEvent{
  final NewsModel updateModel;
  UpdateSuccess(this.updateModel);
}
class UpdateFail extends EditNewsEvent{}