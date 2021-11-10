import 'package:congdongchungcu/bloc/poi/poi_bloc.dart';
import 'package:congdongchungcu/bloc/poi/poi_event.dart';
import 'package:congdongchungcu/bloc/poi/poi_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class SearchBarUI extends StatelessWidget {
  const SearchBarUI({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    POIBloc bloc = BlocProvider.of<POIBloc>(context);
     return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(38.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(0, 2),
                        blurRadius: 8.0),
                  ],
                ),
                child: BlocBuilder<POIBloc, POIState>(
                  bloc: bloc,
                  builder: (context, state){
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 4, bottom: 4),
                    child: TextField(
                      onChanged: (String searchValue) {
                       state.getPoiModel.name = searchValue;
                       print(searchValue);
                      bloc.add(RefreshNews());
                       bloc.add(InputSearchValue(searchValue: searchValue, getPOIModel: state.getPoiModel));
                       bloc.add(GetAllPOIEvent());
                      },
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Tìm kiếm...',
                      ),
                    ),
                  );
                  }
                ),
              ),
            ),
          ),
          // Container(
          //   decoration: BoxDecoration(
          //  color: Colors.white,
          //     borderRadius: const BorderRadius.all(
          //       Radius.circular(38.0),
          //     ),
          //     boxShadow: <BoxShadow>[
          //       BoxShadow(
          //           color: Colors.grey.withOpacity(0.4),
          //           offset: const Offset(0, 2),
          //           blurRadius: 8.0),
          //     ],
          //   ),
          //   child: Material(
          //     color: Colors.transparent,
          //     child: BlocBuilder<POIBloc, POIState>(
          //       bloc: bloc,
          //       builder: (context, state){
          //       return InkWell(
          //         borderRadius: const BorderRadius.all(
          //           Radius.circular(32.0),
          //         ),
          //         onTap: () {
          //           FocusScope.of(context).requestFocus(FocusNode());
          //           print("POImodel  page");
          //           print(state.getPoiModel.name);
          //           // bloc.add(InputSearchValue(searchValue: state.searchValue, getPOIModel: state.getPoiModel));
          //         },
          //         child: Padding(
          //           padding: const EdgeInsets.all(16.0),
          //           child: Icon(FontAwesomeIcons.search,
          //               size: 20,
          //            color: Colors.black,
          //             ),
          //         ),
                
          //       );
          //       }
          //     ),
          //   ),
          // ),
        ],
      ),
       );
  }
}