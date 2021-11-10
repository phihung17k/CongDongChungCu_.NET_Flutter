import 'dart:async';

import 'package:congdongchungcu/bloc/profile_selection/profile_selection_bloc.dart';
import 'package:congdongchungcu/bloc/profile_selection/profile_selection_event.dart';
import 'package:congdongchungcu/bloc/resident_dialog/resident_dialog_event.dart';
import 'package:event_bus/event_bus.dart';

import '../../router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/resident_profile_show.dart';
import 'widgets/welcome_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../dimens.dart';
import 'widgets/add_resident_button.dart';

class ProfileSelectionPage extends StatefulWidget {

  final ProfileSelectionBloc bloc;

  ProfileSelectionPage(this.bloc);

  @override
  _WelcomePage createState() => _WelcomePage();
}

class _WelcomePage extends State<ProfileSelectionPage> {

  ProfileSelectionBloc get bloc => widget.bloc;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.add(GettingResidentInfoEvent());

    bloc.listenerStream.listen((event) {
      if(event is SelectingResidentEvent){
        Navigator.pushNamedAndRemoveUntil(context, Routes.main, (route) => false);
        // Navigator.pushReplacementNamed(context, Routes.main);
      }
    });
  }

  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    // RouteSettings settings = ModalRoute.of(context).settings;
    // if(settings.arguments != null){
    //   List<dynamic> residentIdList = settings.arguments as List<dynamic>;
    //   bloc.add(ArgumentWelcomeEvent(residentIdList));
    // }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(Dimens.size0p6), BlendMode.dstATop),
              image: const AssetImage("assets/images/background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(Dimens.size10),
            child: SingleChildScrollView(
              child: Column(
                children: const [
                  WelcomeText(),
                  ResidentProfileShow(),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: const AddResidentButton(),
      ),
    );
  }
}
