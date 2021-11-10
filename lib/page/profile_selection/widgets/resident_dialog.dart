import 'package:congdongchungcu/bloc/resident_dialog/resident_dialog_bloc.dart';
import 'package:congdongchungcu/bloc/resident_dialog/resident_dialog_event.dart';
import 'package:congdongchungcu/bloc/resident_dialog/resident_dialog_state.dart';
import 'package:congdongchungcu/models/apartment_model.dart';
import 'package:congdongchungcu/models/building_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app_colors.dart';
import '../../../dimens.dart';
import '../models/demo_apartment.dart';
import '../models/demo_building.dart';
import 'package:flutter/material.dart';

class ResidentDialog extends StatefulWidget {
  final _formKey = GlobalKey<FormState>();
  final ResidentDialogBloc bloc;

  ResidentDialog(this.bloc);

  @override
  _ResidentDialogState createState() => _ResidentDialogState();
}

class _ResidentDialogState extends State<ResidentDialog> {

  GlobalKey<FormState> get _formKey => widget._formKey;

  ResidentDialogBloc get bloc => widget.bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.add(LoadingApartmentBuildingEvent());
    bloc.listenerStream.listen((event) {
      if(event is SendingDataToWelcomePage){
        Navigator.of(context, rootNavigator: true).pop(event);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(Dimens.size32))),
        contentPadding: EdgeInsets.only(top: Dimens.size10),
        title: Text(
          'Resident Profile',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: Dimens.size25),
        ),
        content: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Form(
              key: _formKey,
              child: BlocBuilder<ResidentDialogBloc, ResidentDialogState>(
                bloc: bloc,
                builder: (context, state) {
                  // print("state.apartmentList ${state?.apartmentList?.length}");
                  // print("state.apartmentList = null ${state?.apartmentList == null}");
                  if (state is ResidentDialogState &&
                      state.apartmentList != null) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              left: Dimens.size15, right: Dimens.size15),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: RichText(
                                    text: TextSpan(
                                        style: TextStyle(
                                            fontSize: Dimens.size17,
                                            color: Colors.black),
                                        text: "Apartment",
                                        children: const [
                                      TextSpan(
                                          text: ' *',
                                          style: TextStyle(color: Colors.red))
                                    ])),
                              ),
                              Flexible(
                                flex: 6,
                                child: DropdownButton(
                                  hint: const Text('Select apartment'),
                                  isExpanded: true,
                                  value: state.selectedApartment,
                                  items: state.apartmentList
                                      .map((ApartmentModel apartment) {
                                    return DropdownMenuItem<ApartmentModel>(
                                      value: apartment,
                                      child: Text(
                                        apartment.name,
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (apartment) {
                                    // print("newValue apart ${apartment}");
                                    bloc.add(GettingBuildingEvent(apartment));
                                    // setState(() {
                                    //   _selectedApart = newValue;
                                    // });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: Dimens.size15, right: Dimens.size15),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: RichText(
                                    text: TextSpan(
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: Dimens.size17),
                                        text: "Building",
                                        children: const [
                                      TextSpan(
                                          text: ' *',
                                          style: TextStyle(color: Colors.red))
                                    ])),
                              ),
                              Flexible(
                                flex: 6,
                                child: DropdownButton(
                                  hint: const Text('Select Building'),
                                  isExpanded: true,
                                  value: state.selectedBuilding,
                                  items: state.selectedApartment != null
                                      ? state.buildingList
                                          .map((BuildingModel building) {
                                          return DropdownMenuItem<BuildingModel>(
                                            value: building,
                                            child: Text(
                                              building.name,
                                              textAlign: TextAlign.center,
                                            ),
                                          );
                                        }).toList()
                                      : null,
                                  onChanged: state.selectedApartment != null
                                      ? (building) {
                                          print("newValue building $building");
                                          bloc.add(SavingSelectedDataEvent(building));
                                          // setState(() {
                                          //   _selectedBuild = newValue;
                                          // });
                                        }
                                      : null,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(Dimens.size8),
                          child: RaisedButton(
                            color: AppColors.mainColor,
                            child: const Text("Submit",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17)),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                              }
                              if(state.selectedApartment != null && state.selectedBuilding!= null){
                                bloc.add(SendingSelectedDataBack());
                              }
                            },
                          ),
                        )
                      ],
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        )

        // StatefulBuilder(
        //     builder: (BuildContext context, StateSetter setState) {
        //       return Stack(
        //         overflow: Overflow.visible,
        //         children: <Widget>[
        //           Form(
        //             key: _formKey,
        //             child: Column(
        //               mainAxisSize: MainAxisSize.min,
        //               children: <Widget>[
        //                 Padding(
        //                   padding: EdgeInsets.only(
        //                       left: Dimens.size15, right: Dimens.size15),
        //                   child: Row(
        //                     children: [
        //                       Expanded(
        //                         flex: 4,
        //                         child: RichText(
        //                             text: TextSpan(
        //                                 style: TextStyle(
        //                                     fontSize: Dimens.size17,
        //                                     color: Colors.black),
        //                                 text: "Apartment",
        //                                 children: const [
        //                                   TextSpan(
        //                                       text: ' *',
        //                                       style: TextStyle(color: Colors.red))
        //                                 ])),
        //                       ),
        //                       Flexible(
        //                         flex: 6,
        //                         child: DropdownButton(
        //                           hint: const Text('Select apartment'),
        //                           isExpanded: true,
        //                           value:
        //                           _selectedApart != 0 ? _selectedApart : null,
        //                           items: demoApartment.map((Apartment apartment) {
        //                             return DropdownMenuItem<int>(
        //                               value: apartment.id,
        //                               child: Text(
        //                                 apartment.name,
        //                                 textAlign: TextAlign.center,
        //                               ),
        //                             );
        //                           }).toList(),
        //                           onChanged: (newValue) {
        //                             setState(() {
        //                               _selectedApart = newValue;
        //                             });
        //                           },
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                 ),
        //                 Padding(
        //                   padding: EdgeInsets.only(
        //                       left: Dimens.size15, right: Dimens.size15),
        //                   child: Row(
        //                     children: [
        //                       Expanded(
        //                         flex: 4,
        //                         child: RichText(
        //                             text: TextSpan(
        //                                 style: TextStyle(
        //                                     color: Colors.black,
        //                                     fontSize: Dimens.size17),
        //                                 text: "Building",
        //                                 children: const [
        //                                   TextSpan(
        //                                       text: ' *',
        //                                       style: TextStyle(color: Colors.red))
        //                                 ])),
        //                       ),
        //                       Flexible(
        //                         flex: 6,
        //                         child: DropdownButton(
        //                           hint: const Text('Select Building'),
        //                           isExpanded: true,
        //                           value:
        //                           _selectedApart != 0 ? _selectedBuild : null,
        //                           items: _selectedApart != 0
        //                               ? demoApartment[_selectedApart - 1]
        //                               .buildingList
        //                               .map((Building building) {
        //                             return DropdownMenuItem<int>(
        //                               value: building.id,
        //                               child: Text(
        //                                 building.name,
        //                                 textAlign: TextAlign.center,
        //                               ),
        //                             );
        //                           }).toList()
        //                               : null,
        //                           onChanged: _selectedApart != 0
        //                               ? (newValue) {
        //                             setState(() {
        //                               _selectedBuild = newValue;
        //                             });
        //                           }
        //                               : null,
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                 ),
        //                 Padding(
        //                   padding: EdgeInsets.all(Dimens.size8),
        //                   child: RaisedButton(
        //                     color: AppColors.mainColor,
        //                     child: const Text("Submit",
        //                         style:
        //                         TextStyle(color: Colors.white, fontSize: 17)),
        //                     onPressed: () {
        //                       if (_formKey.currentState.validate()) {
        //                         _formKey.currentState.save();
        //                       }
        //                     },
        //                   ),
        //                 )
        //               ],
        //             ),
        //           ),
        //         ],
        //       );
        //     })
        );
  }
}
