import '../../models/news/news_model.dart';

class NewsManageEvent{}

class GettingAllNewsEvent extends NewsManageEvent{}
class IncreaseNewsCurrPage extends NewsManageEvent{}
class RefreshNews extends NewsManageEvent{}
class GetApartmentName extends NewsManageEvent{}
class SaveKeyword extends NewsManageEvent{
  final String keyword;
  SaveKeyword({this.keyword});
}
class SaveDate extends NewsManageEvent{
  final String fromDate;
  final String toDate;
  SaveDate({this.fromDate, this.toDate});
}
class DeleteNews extends NewsManageEvent{
  final int id;
  DeleteNews({this.id});
}
class DeleteSuccess extends NewsManageEvent{}
class DeleteFail extends NewsManageEvent{}
class EditNewsNavigator extends NewsManageEvent{
  final NewsModel editModel;
  EditNewsNavigator({this.editModel});
}
class CreateNewsNavigator extends NewsManageEvent{}
// class DetailNewsNavigator extends NewsManageEvent{
//   final NewsModel detailModel;
//   DetailNewsNavigator({this.detailModel});
// }