import 'package:device_management_app/ui_screens/HomeScreen.dart';
import 'package:device_management_app/ui_screens/SplashScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    home: new SplashScreen(),
    routes: <String, WidgetBuilder>{
      '/HomeScreen': (BuildContext context) => new HomeScreen()
    },
  ));
}
