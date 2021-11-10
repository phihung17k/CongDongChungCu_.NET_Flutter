
import 'package:equatable/equatable.dart';

class CounterState extends Equatable{
  final int count;
  final String title;

  const CounterState({this.count, this.title});

  CounterState copyWith({int count, String title}){
    return CounterState(
        count: count ?? this.count,
        title: title ?? this.title
    );
  }

  @override
  List<Object> get props => [count, title];
}