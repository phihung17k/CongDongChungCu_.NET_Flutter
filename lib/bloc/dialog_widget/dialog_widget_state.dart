
import 'package:equatable/equatable.dart';

class DialogWidgetState extends Equatable{
  final int hour;

  DialogWidgetState({this.hour});

  DialogWidgetState copyWith({int hour}){
    return DialogWidgetState(
      hour: hour ?? this.hour,
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [hour];
}