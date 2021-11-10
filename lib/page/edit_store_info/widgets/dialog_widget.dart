import 'package:congdongchungcu/bloc/dialog_widget/dialog_widget_bloc.dart';
import 'package:congdongchungcu/bloc/dialog_widget/dialog_widget_event.dart';
import 'package:congdongchungcu/bloc/dialog_widget/dialog_widget_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app_colors.dart';

class DialogWidget extends StatefulWidget {
  final DialogWidgetBloc bloc;

  DialogWidget(this.bloc);

  @override
  _DialogWidgetState createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  List<HourWidget> hours;

  DialogWidgetBloc get bloc => widget.bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hours = List.generate(24, (index) => HourWidget(hour: index));

    bloc.listenerStream.listen((event) {
      if (event is SubmitItemEvent) {
        Navigator.of(context).pop(event.hour);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Chọn thời gian mở cửa"),
      content: Container(
        width: 300,
        height: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: BlocBuilder<DialogWidgetBloc, DialogWidgetState>(
                bloc: bloc,
                builder: (context, state) {
                  return ListWheelScrollView(
                    itemExtent: 50,
                    children: List.generate(24, (index) {
                      if (state.hour == index) {
                        return HourWidget(
                            hour: index, color: AppColors.primaryColor);
                      }
                      return HourWidget(hour: index);
                    }),
                    onSelectedItemChanged: (value) {
                      // print("----------value---------$value");
                      bloc.add(SavingChangedItemEvent(value));
                    },
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  bloc.add(SubmitItemEvent());
                },
                child: const Text("Chọn")),
          ],
        ),
      ),
    );
  }
}

class HourWidget extends StatelessWidget {
  final int hour;
  final Color color;

  HourWidget({this.hour, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle, color: color ?? Colors.black12),
      child: Center(
        child: Text("$hour:00"),
      ),
    );
  }
}
