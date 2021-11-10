

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../bloc/counter/counter_event.dart';
import '../bloc/counter/counter_state.dart';
import '../bloc/counter/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../main.dart';

class TestPage extends StatefulWidget {
  final CounterBloc bloc;

  const TestPage(this.bloc);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {

  CounterBloc get bloc => widget.bloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder(
              bloc: bloc,
              builder:(context, CounterState state) {
                return Text(
                  state.title,
                );
              },
            ),
            BlocBuilder(
                bloc: bloc,
                builder: (context, CounterState state) {
                  return Text(
                    '${state.count}',
                    style: Theme.of(context).textTheme.headline4,
                  );
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => bloc.add(TitleEvent()),
        tooltip: 'Incrementa',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
