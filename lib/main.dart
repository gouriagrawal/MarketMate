import 'package:flutter/material.dart';
import 'package:kriti/screens/login_sreen.dart';
import 'package:kriti/screens/registration_screen.dart';
import 'package:kriti/screens/shop_register.dart';
import 'package:kriti/screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context)=> WelcomeScreen(),
        LoginScreen.id: (context)=> LoginScreen(),
        RegistrationScreen.id: (context)=> RegistrationScreen(),
        register_shop.id:(context)=>register_shop(),
      },
    );
  }
}




