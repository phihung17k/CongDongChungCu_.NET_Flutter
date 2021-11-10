
import 'package:congdongchungcu/base_bloc.dart';
import 'package:congdongchungcu/bloc/dialog_widget/dialog_widget_event.dart';
import 'package:congdongchungcu/bloc/dialog_widget/dialog_widget_state.dart';

class DialogWidgetBloc extends BaseBloc<DialogWidgetEvent, DialogWidgetState>{

  DialogWidgetBloc() : super(DialogWidgetState(
    hour: 0,
  )){
    on((event, emit) {
      if(event is SavingChangedItemEvent){
        emit(state.copyWith(
          hour: event.hour
        ));
      } else if(event is SubmitItemEvent){
        listener.add(SubmitItemEvent(
          hour: state.hour
        ));
      }
    });
  }

}