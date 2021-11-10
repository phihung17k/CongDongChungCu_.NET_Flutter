import 'package:congdongchungcu/bloc/poi_manage/poi_manage_bloc.dart';
import 'package:congdongchungcu/bloc/poi_manage/poi_manage_event.dart';
import 'package:congdongchungcu/bloc/poi_manage/poi_manage_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class SearchBarManageUI extends StatelessWidget {
  const SearchBarManageUI({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     POIManageBloc bloc = BlocProvider.of<POIManageBloc>(context);
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
                child: BlocBuilder<POIManageBloc, POIManageState>(
                  bloc: bloc,
                  builder: (context, state){
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 4, bottom: 4),
                    child: TextField(
                      onChanged: (String searchValue) {
                        state.getPoiModel.name = searchValue;
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
          //     child: InkWell(
          //       borderRadius: const BorderRadius.all(
          //         Radius.circular(32.0),
          //       ),
          //       onTap: () {
          //         FocusScope.of(context).requestFocus(FocusNode());
          //       },
          //       child: Padding(
          //         padding: const EdgeInsets.all(16.0),
          //         child: Icon(FontAwesomeIcons.search,
          //             size: 20,
          //          color: Colors.black,
          //           ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}