class UserModel {
  final int id;
  final String username;
  final String fullName;
  final String phone;
  final String email;
  String avaPath;

  bool isSystemAdmin;
  bool status;
  String password;


  UserModel({this.avaPath = "https://iupac.org/wp-content/uploads/2018/05/default-avatar.png", this.password, this.fullName, this.phone, this.email, this.isSystemAdmin, this.status, this.id, this.username});



  factory UserModel.fromJson(Map<String, dynamic> json) {
    if (json == null) throw Exception("Json building model is null");

    bool isSystemAdmin = json['is_system_admin'];
    bool status = json['status'];
    if (status && !isSystemAdmin) {
      int id = json['id'];
      String username = json['username'];
      String fullName = json['fullname'];
      String phone = json['phone'];
      String email = json['email'];
      return UserModel(

        id: id,
        username: username,
        fullName: fullName,
        phone: phone,
        email: email,
        isSystemAdmin: isSystemAdmin,
        status: status
      );
    }
    return null;
  }
}
