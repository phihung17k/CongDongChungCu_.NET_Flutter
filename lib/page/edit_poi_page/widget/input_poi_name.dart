import 'package:congdongchungcu/bloc/edit_poi/edit_poi_bloc.dart';
import 'package:congdongchungcu/bloc/edit_poi/edit_poi_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextfieldInputPOIName extends StatefulWidget {
  @override
  _TextfieldInputPOINameState createState() => _TextfieldInputPOINameState();
}

class _TextfieldInputPOINameState extends State<TextfieldInputPOIName> {
  final _formKeyName = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    EditPOIBloc bloc = BlocProvider.of<EditPOIBloc>(context);
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
            child: BlocBuilder<EditPOIBloc, EditPOIState>(
                bloc: bloc,
                builder: (context, state) {
                  return Form(
                    key: _formKeyName,
                    child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        maxLines: 2,
                        minLines: 1,
                        maxLength: 50,
                        controller: TextEditingController()
                          ..text = state.poiReceive.name,
                        validator: (value) {
                          if (value.length < 3) {
                            return 'Nhập ít nhất 3 ký tự';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (_formKeyName.currentState.validate()) {
                            state.poiReceive.name = value;
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
