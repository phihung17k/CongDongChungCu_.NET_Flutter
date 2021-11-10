import 'package:congdongchungcu/bloc/profile_selection/profile_selection_bloc.dart';
import 'package:congdongchungcu/bloc/profile_selection/profile_selection_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'resident_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../dimens.dart';

class ResidentProfileShow extends StatelessWidget {
  const ResidentProfileShow({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileSelectionBloc bloc = BlocProvider.of<ProfileSelectionBloc>(context);
    return Column(
      children: [
        SizedBox(height: Dimens.size60),
        BlocBuilder<ProfileSelectionBloc, ProfileSelectionState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is LoadingWelcomeState) {
                return const CircularProgressIndicator();
              }
              return ListView.builder(
                itemCount: state.residentList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ResidentCard(
                      resident: state.residentList.elementAt(index));
                },
              );
            }),
      ],
    );
  }
}
