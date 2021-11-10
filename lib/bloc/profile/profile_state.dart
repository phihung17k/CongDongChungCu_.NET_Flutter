import 'package:equatable/equatable.dart';

class ProfileState extends Equatable{
  final String fullname;
  final String email;
  final String phone;

  ProfileState({ this.fullname, this.email, this.phone});

  // const POIState({this.currentListPoi, this.getPoiModel, this.hasNext, this.listPoiType, this.dropdownValue});

  ProfileState copyWith({String fullname, String email, String phone}){
    return ProfileState(
        fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      phone: phone ?? this.phone
    );
  }
  @override
  // TODO: implement props
  List<Object> get props => [fullname, email, phone];
}