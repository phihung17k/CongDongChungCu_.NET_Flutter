import '../../../models/news/get_news_model.dart';
import '../../../models/paging_result_model.dart';

import '../../models/news/news_model.dart';

abstract class INewsService{
  Future<PagingResult<NewsModel>> getNewsByCondition(GetNewsModel model, int apartmentId);
}