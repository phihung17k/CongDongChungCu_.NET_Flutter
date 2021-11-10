import 'package:congdongchungcu/bloc/poi_manage/poi_manage_bloc.dart';
import 'package:congdongchungcu/bloc/poi_manage/poi_manage_event.dart';
import 'package:congdongchungcu/bloc/poi_manage/poi_manage_state.dart';
import 'package:congdongchungcu/models/poi/poi_type_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../router.dart';

class FilterBarPOIMangeUI extends StatelessWidget {
  const FilterBarPOIMangeUI({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    POIManageBloc bloc = BlocProvider.of<POIManageBloc>(context);
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
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
                const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 130,
                            height: 30,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(15)),
                            child: BlocBuilder<POIManageBloc, POIManageState>(
                                bloc: bloc,
                                builder: (context, state) {
                                  POITypeModel dropdownValue ;
                                  if(state.listPoiType.isNotEmpty){
                                    print(state.listPoiType[0].name);
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
                                      iconSize: 24,
                                      elevation: 16,
                                      style: const TextStyle(
                                          color: Colors.deepPurple,
                                          fontWeight: FontWeight.bold),
                                      onChanged: (POITypeModel newValue) {
                                        state.getPoiModel.poiTypeId = newValue.id;
                                      print(state.getPoiModel.poiTypeId);
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
                  ),
                ),
                FloatingActionButton(
                  onPressed: () {
                   Navigator.of(context).pushNamed(Routes.add_poi);
                  },
                  backgroundColor: Colors.teal[300],
                  child: Icon(Icons.add),
                )
              ],
            ),
          ),
        ),
        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Divider(
            height: 1,
          ),
        )
      ],
    );
  }
}
