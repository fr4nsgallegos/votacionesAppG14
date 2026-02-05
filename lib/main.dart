import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:votacionesappg14/firebase_options.dart';
import 'package:votacionesappg14/pages/home_page.dart';
import 'package:votacionesappg14/pages/login_page.dart';
import 'package:votacionesappg14/pages/register_page.dart';
import 'package:votacionesappg14/utils/notification_service.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService.initMessaging();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  runApp(MaterialApp(home: HomePage(), debugShowCheckedModeBanner: false));
}
