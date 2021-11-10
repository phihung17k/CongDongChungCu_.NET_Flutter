
class ProductMyShop {
  final String shopName;
  final String name;
  final String description;
  final int price;
  final String urlImage;
  final String category;
  final int quantitySold;
  final String rate;
  int quantity;


  ProductMyShop({
    this.shopName,
    this.name,
    this.description,
    this.price,
    this.urlImage,
    this.category,
    this.quantitySold,
    this.rate,
    this.quantity
  });

  factory ProductMyShop.fromJson(Map<String, dynamic> json) => ProductMyShop(
    shopName: json['shopName'],
      name: json['name'],
      description: json['description'],
      price: json['price'] ,
      urlImage: json['urlImage'],
      category: json['category'],
      quantitySold: json['quantitySold'],
      rate: json['rate'],
      quantity: json['quantity']
  );

  Map<String, dynamic> toJson() => {
    'shopName': shopName,
    'name': name,
    'description': description,
    'price': price,
    'urlImage': urlImage,
    'category': category,
    'quantitySold': quantitySold,
    'rate': rate,
    'quantity': quantity
  };
}