import 'package:intl/intl.dart';

class NewsModel {
  int id;
  String title;
  String content;
  String createdDate;
  bool status;
  int apartmentId;

  NewsModel({this.id, this.title, this.content, this.createdDate, this.status, this.apartmentId});

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    if (json == null) throw Exception("Json news model cannot null");
    int id = json['id'];
    String title = json['title'];
    String content = json['content'];
    String createdDate = new DateFormat('dd-MM-yyyy HH:mm').format(DateTime.parse(json['created_date']));
    bool status = json['status'];
    int apartmentId = json['apartment_id'];
    return NewsModel(
      id: id,
      title: title,
      content: content,
      createdDate: createdDate,
      status: status,
      apartmentId: apartmentId
    );
  }

  static NewsModel fromJsonModel(Map<String, dynamic> json) => NewsModel.fromJson(json);
}