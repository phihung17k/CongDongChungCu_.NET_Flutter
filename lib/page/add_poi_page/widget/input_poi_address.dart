import 'package:congdongchungcu/bloc/add_poi/add_poi_bloc.dart';
import 'package:congdongchungcu/bloc/add_poi/add_poi_event.dart';
import 'package:congdongchungcu/bloc/add_poi/add_poi_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextfieldInputPOIAddressAdd extends StatefulWidget {
  @override
  _TextfieldInputPOIAddressAddState createState() =>
      _TextfieldInputPOIAddressAddState();
}

class _TextfieldInputPOIAddressAddState
    extends State<TextfieldInputPOIAddressAdd> {
  final _formKeyAddress = GlobalKey<FormState>();

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
          Text(
            "Địa chỉ:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: size.width,
            child: BlocBuilder<AddPOIBloc, AddPOIState>(
                bloc: bloc,
                builder: (context, state) {
                  return Form(
                    key: _formKeyAddress,
                    child: TextFormField(
                        // controller: TextEditingController()..text = state.poiReceive.address,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        maxLength: 100,
                        minLines: 1,
                        maxLines: 3,
                        validator: (value) {
                          if (value.length < 3) {
                            return 'Nhập ít nhất 3 ký tự';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (_formKeyAddress.currentState.validate()) {
                            bloc.add(GetPoiAddress(address: value));
                          }
                          //   state.poiReceive.address = value;
                        }),
                  );
                }),
          )
        ],
      ),
    );
  }
}
