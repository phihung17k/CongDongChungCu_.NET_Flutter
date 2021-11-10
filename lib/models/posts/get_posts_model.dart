import '../enum.dart';

class GetPostsModel {
    int apartmentId;
    String title;
    Status status;
    int currPage;

    GetPostsModel({this.apartmentId, this.title, this.status, this.currPage});
}