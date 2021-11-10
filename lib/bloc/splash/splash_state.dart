
import 'package:equatable/equatable.dart';

class SplashState extends Equatable{
  final double opacity;

  SplashState({this.opacity});

  SplashState copyWith({double opacity}){
    return SplashState(
      opacity: opacity ?? this.opacity
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [opacity];
}