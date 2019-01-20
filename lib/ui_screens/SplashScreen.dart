import 'dart:async';

import 'package:device_management_app/data_base/Database.dart';
import 'package:device_management_app/model/User.dart';
import 'package:device_management_app/ui_screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

bool isLogined = false;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs
        .getKeys()
        .length > 0) {
      User tempUser = await DBProvider.db.getUser(prefs.getString("id"));

      if (tempUser != null && tempUser.password == prefs.getString("pass")) {
        setState(() {
          isLogined = true;
        });
      }
    }

    if (isLogined)
      Navigator.of(context).pushReplacementNamed('/HomeScreen');
    else
      Navigator.of(context).pushReplacementNamed('/LoginScreen');
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
