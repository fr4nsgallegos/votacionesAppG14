import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:votacionesappg14/firebase_options.dart';
import 'package:votacionesappg14/pages/home_page.dart';
import 'package:votacionesappg14/pages/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(home: RegisterPage(), debugShowCheckedModeBanner: false));
}
