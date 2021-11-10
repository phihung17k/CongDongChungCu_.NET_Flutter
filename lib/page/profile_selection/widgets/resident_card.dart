import 'package:congdongchungcu/bloc/profile_selection/profile_selection_bloc.dart';
import 'package:congdongchungcu/bloc/profile_selection/profile_selection_event.dart';
import 'package:congdongchungcu/page/register/register_page.dart';
import '../../../models/resident_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../dimens.dart';
import '../../../router.dart';
import '../../main_page/main_page.dart';
import '../Models/demo_residents.dart';

class ResidentCard extends StatelessWidget {
  const ResidentCard({
    Key key,
    this.width = 250,
    this.aspectRetio = 1.02,
    this.resident,
  }) : super(key: key);

  final double width, aspectRetio;
  final ResidentModel resident;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(Dimens.size10),
        padding: EdgeInsets.all(Dimens.size10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(Dimens.size0p8),
          borderRadius: BorderRadius.circular(18),
        ),
        child: SizedBox(
            width: width,
            child: GestureDetector(
              onTap: () {
                BlocProvider.of<ProfileSelectionBloc>(context)
                    .add(SelectingResidentEvent(resident: resident));
              },
              child: Column(
                children: [
                  Text(
                    resident.apartmentModel.name,
                    style: TextStyle(
                        fontSize: Dimens.size22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: Dimens.size5),
                  Text(
                    resident.buildingModel.name,
                    style:
                        TextStyle(fontSize: Dimens.size18, color: Colors.black),
                  )
                ],
              ),
            )));
  }
}
