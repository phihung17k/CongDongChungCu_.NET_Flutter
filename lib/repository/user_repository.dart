import 'package:congdongchungcu/models/poi/poi_model.dart';

import '../models/resident_model.dart';

class UserRepository {
  int id;
  String idToken;
  String username;
  String email;
  String fullname;
  String phone;
  String imagePath;
  List<ResidentModel> residentList;
  ResidentModel selectedResident;
  List<POIModel> poiList;
  POIModel selectedPOI;
  // String authToken;

  UserRepository({this.id,
    this.idToken,
    this.username,
    this.email,
    this.fullname,
    this.phone,
    this.imagePath,
    this.residentList,
    this.selectedResident,
    this.poiList,
    this.selectedPOI,
    // this.authToken
  });

  UserRepository get currentUser =>
      UserRepository(
          id: id,
          idToken: idToken,
          username: username,
          email: email,
          fullname: fullname,
          phone: phone,
          imagePath: imagePath,
          residentList: residentList,
          selectedResident: selectedResident,
          poiList: poiList,
          selectedPOI: selectedPOI,
          // authToken: authToken
      );

  void reset() {
    id = null;
    idToken = null;
    username = null;
    email = null;
    fullname = null;
    phone = null;
    imagePath = null;
    residentList = null;
    selectedResident = null;
    poiList = null;
    selectedPOI = null;
    // authToken = null;
  }
}
