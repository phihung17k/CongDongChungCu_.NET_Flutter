import 'package:congdongchungcu/bloc/poi/poi_bloc.dart';
import 'package:congdongchungcu/bloc/poi/poi_event.dart';
import 'package:congdongchungcu/bloc/poi/poi_state.dart';
import 'package:congdongchungcu/models/poi/poi_type_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterBarUI extends StatelessWidget {
  const FilterBarUI({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    POIBloc bloc = BlocProvider.of<POIBloc>(context);
    return Stack(
      children: <Widget>[
        Positioned(
          child: Container(
            height: 24,
            decoration: BoxDecoration(
              color: Colors.black,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: const Offset(0, -2),
                    blurRadius: 8.0),
              ],
            ),
          ),
        ),
        Container(
          color: Colors.white,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                     Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 130,
                            height: 30,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(15)),
                            child: BlocBuilder<POIBloc, POIState>(
                                bloc: bloc,
                                builder: (context, state) {
                                  POITypeModel dropdownValue ;
                                  if(state.listPoiType.isNotEmpty){
                                    if(state.dropdownValue != null){
                                      dropdownValue = state.dropdownValue;
                                    }else{
                                       dropdownValue = state.listPoiType[0];
                                    }
                                  }
                                  
                                  return DropdownButtonHideUnderline(
                                    child: DropdownButton<POITypeModel>(
                                      value: dropdownValue,
                                      icon: const Icon(Icons.arrow_drop_down),
                                      iconSize: 26,
                                      elevation: 16,
                                      style: const TextStyle(
                                          color: Colors.deepPurple,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                      onChanged: (POITypeModel newValue) {
                                        state.getPoiModel.poiTypeId = newValue.id;  
                                        bloc.add(RefreshNews());         
                                        bloc.add(SelectDropdownNewValue(dropdownNewValue: newValue, getPOIModel: state.getPoiModel));                                 
                                        bloc.add(GetAllPOIEvent());
                                      },
                                      
                                      items: state.listPoiType.map<DropdownMenuItem<POITypeModel>>(
                                          (POITypeModel value) {
                                        return DropdownMenuItem<POITypeModel>(
                                          value: value,
                                          child: Text(value.name),
                                        );
                                      }).toList(),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
