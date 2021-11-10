class CategoryModel
{
    int id;
    String name;

    CategoryModel({this.id, this.name});

    factory CategoryModel.fromJson(Map<String, dynamic> json)
    {
      if (json == null) throw Exception("Json news model cannot null");
      int id = json['id'];
      String name = json['name'];

      return CategoryModel(
        id: id,
        name: name
      );
    }

    // void abc()
    // {
    //   print("a");
    // }

    // hàm này trả ra 1 object Model
    //trả ra 1 đối tượng product từ Map<Key,Value> của json['item']
    static CategoryModel fromJsonModel(Map<String, dynamic> json) => CategoryModel.fromJson(json);

}