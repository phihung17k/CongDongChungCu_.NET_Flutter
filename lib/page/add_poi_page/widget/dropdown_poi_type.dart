import 'package:congdongchungcu/bloc/add_poi/add_poi_bloc.dart';
import 'package:congdongchungcu/bloc/add_poi/add_poi_event.dart';
import 'package:congdongchungcu/bloc/add_poi/add_poi_state.dart';
import 'package:congdongchungcu/models/poi/poi_type_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class DropdownPOITypeUIAdd extends StatefulWidget {

  @override
  _DropdownPOITypeUIAddState createState() => _DropdownPOITypeUIAddState();
}

class _DropdownPOITypeUIAddState extends State<DropdownPOITypeUIAdd> {
  
  @override
  Widget build(BuildContext context) {
    AddPOIBloc bloc = BlocProvider.of<AddPOIBloc>(context);
    return Container(
                width: 130,
                height: 30,
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(15)),
                child: BlocBuilder<AddPOIBloc, AddPOIState>(
                  bloc: bloc,
                  builder: (context, state){
                     int dropdownValue = state.dropdownNewValue;                   
                  return DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      value: state.dropdownNewValue,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
                      onChanged: (int newValue) {
                        bloc.add(ChangeDropdownValue(dropdownNewValue: newValue));
                      },
                      items: state.listPoiType.map<DropdownMenuItem<int>>((POITypeModel value) {
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