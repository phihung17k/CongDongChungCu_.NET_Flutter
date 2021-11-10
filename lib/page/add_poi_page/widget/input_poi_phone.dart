import 'package:congdongchungcu/bloc/add_poi/add_poi_bloc.dart';
import 'package:congdongchungcu/bloc/add_poi/add_poi_event.dart';
import 'package:congdongchungcu/bloc/add_poi/add_poi_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextfieldInputPOIPhoneAdd extends StatefulWidget {
  @override
  _TextfieldInputPOIPhoneAddState createState() =>
      _TextfieldInputPOIPhoneAddState();
}

class _TextfieldInputPOIPhoneAddState extends State<TextfieldInputPOIPhoneAdd> {
  final _formKeyPhone = GlobalKey<FormState>();

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
          Text("Liên hệ: ", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(
            height: 5,
          ),
          Container(
            width: size.width,
            child: BlocBuilder<AddPOIBloc, AddPOIState>(
                bloc: bloc,
                builder: (context, state) {
                  return Form(
                    key: _formKeyPhone,
                    child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        maxLines: 1,
                        maxLength: 15,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.length < 4) {
                            return 'Nhập ít nhất 4 ký tự';
                          }
                          return null;
                        },
                        // controller: TextEditingController()..text = state.poiReceive.phone,
                        onChanged: (value) {
                          if (_formKeyPhone.currentState.validate()) {
                            bloc.add(GetPoiPhone(phone: value));
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
