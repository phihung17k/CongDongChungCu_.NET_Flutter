import 'package:congdongchungcu/bloc/profile_selection/profile_selection_bloc.dart';
import 'package:congdongchungcu/bloc/profile_selection/profile_selection_event.dart';
import 'package:congdongchungcu/bloc/resident_dialog/resident_dialog_bloc.dart';
import 'package:congdongchungcu/bloc/resident_dialog/resident_dialog_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../router.dart';
import 'resident_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../app_colors.dart';

class AddResidentButton extends StatelessWidget {
  const AddResidentButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: AppColors.mainColor,
      icon: const Icon(Icons.add),
      label: const Text('Add Resident Profile'),
      onPressed: () async {
        SendingDataToWelcomePage data = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return ResidentDialog(GetIt.I.get<ResidentDialogBloc>());
            });
        if(data != null){
          BlocProvider.of<ProfileSelectionBloc>(context).add(ReloadingResidentEvent(
              newApartment: data.selectedApartment,
              newBuilding: data.selectedBuilding
          ));
        }
      },
    );
  }
}
