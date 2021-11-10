class GetPOIModel {
  String name;
  int apartmentId;   
  int poiTypeId;
  bool status;
  int currPage;

  GetPOIModel(
      {this.name, this.apartmentId, this.poiTypeId, this.status, this.currPage});
}