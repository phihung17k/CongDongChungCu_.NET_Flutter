class GetNewsModel {
  String keyword;
  String fromDate;
  String toDate;
  bool status;
  int currPage;

  GetNewsModel(
      {this.keyword, this.fromDate, this.toDate, this.status, this.currPage});
}