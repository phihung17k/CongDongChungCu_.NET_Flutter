import '../../../bloc/news_manage/news_manage_bloc.dart';
import '../../../bloc/news_manage/news_manage_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import '../../../dimens.dart';

class BasicDateField extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd");
  String fromDate, toDate;
  final _fromDateController = TextEditingController();
  final _toDateController = TextEditingController();

  BasicDateField({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    NewsManageBloc _bloc = BlocProvider.of<NewsManageBloc>(context);
    return Padding(
      padding: EdgeInsets.all(Dimens.size10),
      child: Column(
        children: [
          Row(children: <Widget>[
            Expanded(
              flex: 11,
              child: Container(
                height: Dimens.size45,
                child: DateTimeField(
                  controller: _fromDateController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: Dimens.size1),
                    ),
                    labelText: 'From Date',
                  ),
                  format: format,
                  onShowPicker: (context, currentValue) {
                    return showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100));
                  },
                ),
              ),
            ),
            const Expanded(
              flex: 1,
              child: SizedBox(),
            ),
            Expanded(
              flex: 11,
              child: Container(
                height: Dimens.size45,
                child: DateTimeField(
                  controller: _toDateController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: Dimens.size1),
                    ),
                    labelText: "To Date",
                  ),
                  format: format,
                  onShowPicker: (context, currentValue) {
                    return showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100));
                  },
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  IconButton(icon: const Icon(Icons.filter_alt),
                    onPressed: (){
                    //checkValid
                      fromDate = _fromDateController.text;
                      toDate = _toDateController.text;
                      _bloc.add(SaveDate(fromDate: fromDate, toDate: toDate));
                      _bloc.add(GettingAllNewsEvent());
                    },),
                  Text("Filter", style: TextStyle(fontSize: Dimens.size10),)
                ],
              ),
            )
          ]),
        ],
      ),
    );
  }
}