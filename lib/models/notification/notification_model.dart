
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class NotiModel implements Comparable<NotiModel>{
  final int id;
  final String title;
  final String content;
  final DateTime sortDate;
  final String createdDate;

  factory NotiModel.fromJson(Map<String, dynamic> json) {
    if (json == null) throw Exception("Json news model cannot null");
    int id = json['Id'];
    String title = json['Title'];
    String content = json['Content'];
    DateTime sortDate = (json['DateCreate'] as Timestamp).toDate();
    String createdDate = new DateFormat('dd-MM-yyyy HH:mm').format(sortDate);
    return NotiModel(
        id: id,
        title: title,
        content: content,
        sortDate: sortDate,
        createdDate: createdDate,
    );
  }

  NotiModel({this.id, this.title, this.content,this.sortDate, this.createdDate});

  @override
  int compareTo(NotiModel other) {
    int order = other.sortDate.compareTo(sortDate);
    return order;
  }
}