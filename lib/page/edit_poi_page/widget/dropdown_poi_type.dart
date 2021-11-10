import 'package:congdongchungcu/bloc/edit_poi/edit_poi_bloc.dart';
import 'package:congdongchungcu/bloc/edit_poi/edit_poi_event.dart';
import 'package:congdongchungcu/bloc/edit_poi/edit_poi_state.dart';
import 'package:congdongchungcu/models/poi/poi_type_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class DropdownPOITypeUI extends StatefulWidget {

  @override
  _DropdownPOITypeUIState createState() => _DropdownPOITypeUIState();
}

class _DropdownPOITypeUIState extends State<DropdownPOITypeUI> {
  
  @override
  Widget build(BuildContext context) {
    EditPOIBloc bloc = BlocProvider.of<EditPOIBloc>(context);
    return Container(
                width: 130,
                height: 30,
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(15)),
                child: BlocBuilder<EditPOIBloc, EditPOIState>(
                  bloc: bloc,
                  builder: (context, state){
                   int dropdownValue = state.poiReceive.poitype_id;
                  return DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
                      onChanged: (int newValue) {
                        bloc.add(SelectDropdownValue(dropdownValue: newValue));
                        state.poiReceive.poitype_id = newValue;
                      },
                      items: state.listPoiTypeEdit.map<DropdownMenuItem<int>>((POITypeModel value) {
                        return DropdownMenuItem<int>(
                          value: value.id,
                          child: Text(value.name),
                        );
                      }).toList(),
                    ),
                  );
                  }
                ),
              );
  }
}