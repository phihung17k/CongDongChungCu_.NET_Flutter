import 'package:congdongchungcu/bloc/add_poi/add_poi_bloc.dart';
import 'package:congdongchungcu/bloc/add_poi/add_poi_event.dart';
import 'package:congdongchungcu/bloc/add_poi/add_poi_state.dart';
import 'package:congdongchungcu/bloc/edit_poi/edit_poi_bloc.dart';
import 'package:congdongchungcu/bloc/edit_poi/edit_poi_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextfieldInputPOINameAdd extends StatefulWidget {
  @override
  _TextfieldInputPOINameAddState createState() =>
      _TextfieldInputPOINameAddState();
}

class _TextfieldInputPOINameAddState extends State<TextfieldInputPOINameAdd> {
  final _formKeyName = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AddPOIBloc bloc = BlocProvider.of<AddPOIBloc>(context);
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Tên địa điểm: ", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(
            height: 5,
          ),
          Container(
            width: size.width,
            child: BlocBuilder<AddPOIBloc, AddPOIState>(
                bloc: bloc,
                builder: (context, state) {
                  return Form(
                    key: _formKeyName,
                    child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        maxLength: 50,
                        minLines: 1,
                        maxLines: 2,
                        validator: (value) {
                          if (value.length < 3) {
                            return 'Nhập ít nhất 3 ký tự';
                          }
                          return null;
                        },
                        //  controller: TextEditingController()..text = state.poiReceive.name,
                        onChanged: (value) {
                          if (_formKeyName.currentState.validate()) {
                            bloc.add(GetPoiName(name: value));
                          }
                        }),
                  );
                }),
          )
        ],
      ),
    );
  }
}
