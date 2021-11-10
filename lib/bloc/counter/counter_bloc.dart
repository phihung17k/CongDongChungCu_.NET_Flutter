import '../../base_bloc.dart';
import 'counter_event.dart';
import 'counter_state.dart';

class CounterBloc extends BaseBloc<CounterEvent, CounterState> {


  CounterBloc() : super(const CounterState(
      count: 0, title: 'You have pushed the button this many  times:')) {
    on((event, emit) {
      if (event is TitleEvent) {
        emit(state.copyWith(title: "Change something"));
      }
      if (event is CounterEvent) {
        emit(state.copyWith(count: state.count + 1));
      }
    });

    // on<CounterEvent>((event, emit) {
    //   print("state.count ${state?.count} and then ${state.count + 1}");
    //   emit(state.copyWith(count: state.count + 1));
    // });CounterState(count: state.count+1)
  }
}