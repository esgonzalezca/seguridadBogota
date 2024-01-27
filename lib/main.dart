import 'package:flutter/material.dart';
import 'package:startertemplate/pages/auth_page.dart';
import 'package:startertemplate/pages/home_page.dart';
import 'package:startertemplate/pages/login_or_register_page.dart';
import 'package:startertemplate/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:startertemplate/pages/map_sample.dart';
import 'firebase_options.dart';

/*

S T A R T

This is the starting point for all apps. 
Everything starts at the main function

*/
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform
 /* name: "authorizationtemplate-7776a"*/);
  // lets run our app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      // this is bringing us to the LoginPage first
      home: AuthPage(),
    );
  }
}
