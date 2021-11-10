import '../../bloc/notification/notification_event.dart';

import '../../page/notification/widgets/list_noti.dart';

import '../../bloc/notification/notification_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_colors.dart';
import 'package:flutter/material.dart';

import '../../dimens.dart';

class NotificationPage extends StatefulWidget {
  final NotificationBloc bloc;

  const NotificationPage(this.bloc, {Key key}) : super(key: key);

  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<NotificationPage> {
  NotificationBloc get _bloc => widget.bloc;

  @override
  void initState() {
    super.initState();
    _bloc.add(GettingAllNotiEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          centerTitle: true,
          title: const Text('Thông báo',
            style: TextStyle(color: Colors.black54, fontSize: 23),),
        ),
        body: Stack(children: <Widget>[
          Padding(
              padding: EdgeInsets.all(Dimens.size10),
              child: const ListNotification()),
        ]),
      ),
    );
  }
}
