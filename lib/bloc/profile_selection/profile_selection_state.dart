import '../../models/resident_model.dart';
import 'package:equatable/equatable.dart';

class ProfileSelectionState extends Equatable {
  final List<ResidentModel> residentList;

  ProfileSelectionState({this.residentList});

  ProfileSelectionState copyWith({List<ResidentModel> residentList}) {
    return ProfileSelectionState(residentList: residentList ?? this.residentList);
  }

  @override
  // TODO: implement props
  List<Object> get props => [residentList];
}

class LoadingWelcomeState extends ProfileSelectionState {}
