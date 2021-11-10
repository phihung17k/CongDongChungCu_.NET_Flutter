import 'package:congdongchungcu/log.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'app_colors.dart';
import 'dependencies/app_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'router.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  Log.i("Handling a background message: ${message.messageId}");
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.',
  // description
  importance: Importance.high,
);


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDependencies.setup();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.subscribeToTopic('cdcc');
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MaterialApp(
    title: 'Cộng đồng chung cư',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        buttonTheme: ButtonThemeData(
            buttonColor: AppColors.primaryColor,
            textTheme: ButtonTextTheme.primary)),
    initialRoute: Routes.splash,
    onGenerateRoute: (settings) => Routes.getRoute(settings),
  ));
}

