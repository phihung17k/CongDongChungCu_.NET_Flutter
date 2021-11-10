import 'package:congdongchungcu/bloc/edit_poi/edit_poi_bloc.dart';
import 'package:congdongchungcu/bloc/edit_poi/edit_poi_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextfieldInputPOIAddress extends StatefulWidget {
  @override
  _TextfieldInputPOIAddressState createState() =>
      _TextfieldInputPOIAddressState();
}

class _TextfieldInputPOIAddressState extends State<TextfieldInputPOIAddress> {
  final _formKeyAddress = GlobalKey<FormState>();

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
          Text(
            "Địa chỉ:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: size.width,
            child: BlocBuilder<EditPOIBloc, EditPOIState>(
                bloc: bloc,
                builder: (context, state) {
                  return Form(
                    key: _formKeyAddress,
                    child: TextFormField(
                        controller: TextEditingController()
                          ..text = state.poiReceive.address,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        maxLines: 3,
                        minLines: 1,
                        maxLength: 100,
                        validator: (value) {
                          if (value.length < 3) {
                            return 'Nhập ít nhất 3 ký tự';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (_formKeyAddress.currentState.validate()) {
                            state.poiReceive.address = value;
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
