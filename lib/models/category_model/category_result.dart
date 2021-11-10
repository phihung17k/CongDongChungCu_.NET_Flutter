import 'package:congdongchungcu/models/category_model/category_model.dart';

class CategoryResult
{
  List<CategoryModel> listCate;

  CategoryResult({this.listCate});

  //Json trả ra từ Server ở đây hứng nó
   factory CategoryResult.fromJson(Map<String, dynamic>json, )
   {
     if (json == null) throw Exception("Json news model cannot null");
     //chuyển list của json sang dạng list<Map<Key,Value>> 1 Map tương ứng với 1 record
      final items = json['items'].cast<Map<String, dynamic>>();
     //
     List<CategoryModel> list_items = new List<CategoryModel>.from(items.map((itemsJson) => CategoryModel.fromJsonModel(itemsJson)));
     return CategoryResult(listCate: list_items);
   }

}