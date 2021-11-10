import 'package:congdongchungcu/models/resident_model.dart';
import 'package:congdongchungcu/models/user_model.dart';

import '../enum.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

class PostModel {
  int id;
  String title;
  String content;
  String createdDate;
  Status status;
  int residentId;
  UserModel userModel;
  String imagePath;

  PostModel(
      {this.id,
      this.title,
      this.content,
      this.createdDate,
      this.status,
      this.residentId,
      this.userModel,
      this.imagePath});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    if (json == null) throw Exception("Json posts model cannot null");
    int id = json['id'];
    String title = json['title'];
    Status status = Status.values[int.parse(json['status'].toString())];
    String content = json['content'];
    String createdDate = DateFormat('dd-MM-yyyy HH:mm')
        .format(DateTime.parse(json['created_date']));
    int residentId = json['resident_id'];
    return PostModel(
      id: id,
      title: title,
      content: content,
      status: status,
      createdDate: createdDate,
      residentId: residentId,
    );
  }

  static PostModel fromJsonModel(Map<String, dynamic> json) =>
      PostModel.fromJson(json);
}
