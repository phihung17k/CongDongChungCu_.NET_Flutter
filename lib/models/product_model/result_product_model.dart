// import '/models/product_model/product_model.dart';
//
// class ResultProductModel {
//   final int curPage;
//   final int totalPage;
//   final int pageSize;
//   final int totalCount;
//   final bool hasPrevious;
//   final bool hasNext;
//   final List<ProductModel> listProduct;
//
//   ResultProductModel({
//     this.curPage,
//     this.totalPage,
//     this.pageSize,
//     this.totalCount,
//     this.hasPrevious,
//     this.hasNext,
//     this.listProduct
// });
//
//
//   //tạo instance của class ResultProductModel
//   factory ResultProductModel.fromJson(Map<String, dynamic>json)
//   {
//     if (json == null) throw Exception("Json building model cannot null");
//     //
//     int curPage = json['curr_page'];
//     int totalPage = json['total_pages'];
//     int pageSize = json['page_size'];
//     int totalCount = json['total_count'];
//     bool hasPrevious = json['hasPrevious'];
//     bool hasNext = json['hasNext'];
//     List<ProductModel> listProduct;
//
//     //lấy items là 1 list trong đó phần tử item là 1 {key - value,....}
//     List<dynamic> items = json['items'] as List<dynamic>;
//     for (dynamic temp in items) {
//       Map<String, dynamic> item = temp as Map<String, dynamic>;
//       var product = ProductModel(
//         id: item['id'],
//         name: item['name'],
//         price: item['price'],
//         description: item['description'],
//         status: item['status'],
//         categoryName: item['category_name']
//       );
//       listProduct.add(product);
//     }
//
//     return ResultProductModel(
//       curPage: curPage,
//       totalPage: totalPage,
//       pageSize: pageSize,
//       totalCount: totalCount,
//       hasPrevious: hasPrevious,
//       hasNext: hasNext,
//       listProduct:listProduct
//     );
//   }
// }