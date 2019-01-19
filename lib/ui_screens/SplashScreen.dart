import 'dart:async';

import 'package:device_management_app/ui_screens/HomeScreen.dart';
import 'package:flutter/material.dart';

import './AddressScreen.dart';
import './LoginScreen.dart';
import './RegistrationScreen.dart';

void main() {
  runApp(new MaterialApp(
    home: new SplashScreen(),
    routes: <String, WidgetBuilder>{
      '/LoginScreen': (BuildContext context) => new LoginScreen(),
      '/RegistrationScreen': (BuildContext context) => new RegistrationScreen(),
      '/HomeScreen': (BuildContext context) => new HomeScreen(),
      '/AddressScreen': (BuildContext context) => new AddressScreen()
    },
  ));
}

bool isLogin = true;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    if (isLogin)
      Navigator.of(context).pushReplacementNamed('/LoginScreen');
    else
      Navigator.of(context).pushReplacementNamed('/HomeScreen');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Image.asset('images/logo_splash.png'),
      ),
    );
  }
}
