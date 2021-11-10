import 'package:congdongchungcu/bloc/edit_poi/edit_poi_bloc.dart';
import 'package:congdongchungcu/bloc/edit_poi/edit_poi_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextfieldInputPOIPhone extends StatefulWidget {
  @override
  _TextfieldInputPOIPhoneState createState() => _TextfieldInputPOIPhoneState();
}

class _TextfieldInputPOIPhoneState extends State<TextfieldInputPOIPhone> {
  final _formKeyPhone = GlobalKey<FormState>();

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
          Text("Liên hệ: ", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(
            height: 5,
          ),
          Container(
            width: size.width,
            child: BlocBuilder<EditPOIBloc, EditPOIState>(
                bloc: bloc,
                builder: (context, state) {
                  return Form(
                    key: _formKeyPhone,
                    child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        maxLength: 15,
                        controller: TextEditingController()
                          ..text = state.poiReceive.phone,
                        validator: (value) {
                          if (value.length < 4) {
                            return 'Nhập ít nhất 4 ký tự';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (_formKeyPhone.currentState.validate()) {
                            state.poiReceive.phone = value;
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
