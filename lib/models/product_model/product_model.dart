import 'dart:ffi';

import 'package:congdongchungcu/models/category_model/category_model.dart';
import 'package:equatable/equatable.dart';

import '../enum.dart';

class ProductModel extends Equatable
{
   int id;
   String name;
   double price;
   String description;
   Status status;
   int categoryId;
   int storeId;
   String storeName;
   String categoryName;
   String imagePath;

   ProductModel({
     this.id,
     this.name,
     this.price,
     this.description,
     this.status,
     this.storeId,
     this.storeName,
     this.categoryId,
     this.categoryName,
     this.imagePath
   });

   //từ list<Map<Key,Value>> của json['item'] đưa vào 1 phần tử list của nó
   //trả ra 1 đối tượng product từ Map<Key,Value>
   factory ProductModel.fromJson(Map<String, dynamic> json)
   {
     if (json == null) throw Exception("Json news model cannot null");
     int id = json['id'];
     String name =  json['name'];
     //?? chưa tìm ra nguyên nhân
     double price = double.parse(json['price'].toString());
     String description = json['description'] ;
     //??
     Status status =  Status.values[int.parse(json['status'].toString())];
     int storeId = json['store_id'];
     String storeName = json['name_store'];
     int categoryId = json['category_id'];
     String categoryName = json['category_name'];


     return ProductModel(
         id: id ,
         name: name,
         price: price,
         description: description ,
         status: status ,
         storeName: storeName,
         storeId: storeId,
         categoryId: categoryId,
         categoryName: categoryName
     );
   }

   // hàm này trả ra 1 object Model
   //trả ra 1 đối tượng product từ Map<Key,Value> của json['item']
   static ProductModel fromJsonModel(Map<String, dynamic> json) => ProductModel.fromJson(json);


   @override
  String toString() {
    return "$id - $name - $status - $description - $price - $imagePath";
  }

  static List<ProductModel> ProductList = <ProductModel>[
    ProductModel(
      id: 1,
      name: "Rau cải",
      //price: 2500,
      description: "Đây là rau củ quả" ,
      status: Status.Approved,

    ),

     ProductModel(
         id: 2,
         name: "Rau răm",
         //price: 3000,
         description:"Đây là rau răm" ,
         status: Status.Approved,

     ),

     ProductModel(
         id: 3,
         name: "Rau cá diếp",
         //price: 3000,
         description:"Đây là cá diếp" ,
         status: Status.Approved,

     ),

     ProductModel(
         id: 4,
         name: "Rau càng cua",
         //price: 3500,
         description:"Đây là càng cua" ,
         status: Status.Approved,

     ),

     ProductModel(
         id: 1,
         name: "Rau cải",
         //price: 2500,
         description: "Đây là rau củ quả" ,
         status: Status.Approved,

     ),

     ProductModel(
         id: 1,
         name: "Rau cải",
         //price: 2500,
         description: "Đây là rau củ quả" ,
         status: Status.Approved,

     ),

     ProductModel(
         id: 1,
         name: "Rau cải",
         //price: 2500,
         description: "Đây là rau củ quả" ,
         status: Status.Approved,

     ),

     ProductModel(
         id: 3,
         name: "Rau cá diếp",
         //price: 3000,
         description:"Đây là cá diếp" ,
         status: Status.Approved,

     ),

     ProductModel(
         id: 3,
         name: "Rau cá diếp",
         //price: 3000,
         description:"Đây là cá diếp" ,
         status: Status.Approved,

     ),

     ProductModel(
         id: 3,
         name: "Rau cá diếp",
         //price: 3000,
         description:"Đây là cá diếp" ,
         status: Status.Approved,

     ),

     ProductModel(
         id: 3,
         name: "Rau cá diếp",
         //price: 3000,
         description:"Đây là cá diếp" ,
         status: Status.Approved,

     ),

     ProductModel(
         id: 3,
         name: "Rau cá diếp",
         //price: 3000,
         description:"Đây là cá diếp" ,
         status: Status.Approved,

     ),

   ];

  @override
  // TODO: implement props
  List<Object> get props => [
    price,
    description,
    status
  ];

}



