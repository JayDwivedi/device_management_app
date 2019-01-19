import 'dart:async';

import 'package:device_management_app/data_base/Database.dart';
import 'package:device_management_app/model/User.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  static String tag = 'login-page';

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  bool _isRemember = false;
  TextEditingController emailController =
      new TextEditingController(text: "jaidwivedi21@gmail.com");
  TextEditingController passwordController =
      new TextEditingController(text: "12345678");

  void saveLoginCredential() async {
    print("Email:- " +
        emailController.text +
        "password:- " +
        passwordController.text);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("id", emailController.text);
    await prefs.setString("pass", passwordController.text);
  }

  Future<bool> validateUserCredential() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getKeys().length > 0) {
      if (prefs.getString("id") == emailController.text &&
          prefs.getString("pass") == passwordController.text) {
        print("Email:- " +
            emailController.text +
            "password:- " +
            passwordController.text);
        User tempUser = await DBProvider.db.getUser(emailController.text);
        if (tempUser != null &&
            tempUser.emailId == emailController.text &&
            tempUser.password == passwordController.text) return true;
      }
    } else {
      User tempUser = await DBProvider.db.getUser(emailController.text);
      if (tempUser != null &&
          tempUser.emailId == emailController.text &&
          tempUser.password == passwordController.text) return true;
    }
    return false;
  }

  void showToast(var message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black45,
        textColor: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('images/logo_splash.png'),
      ),
    );

    final email = TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      controller: passwordController,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          validateUserCredential().then((onValue) {
            if (onValue) {
              if (_isRemember) saveLoginCredential();

              Navigator.of(context).pushReplacementNamed('/HomeScreen');
            } else
              showToast("Please enter correct credential");
          });
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );

    _launchURL() async {
      const url = 'https://flutter.io';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    final rememberMeCheckBox = CheckboxListTile(
      onChanged: (bool newValue) {
        setState(() {
          _isRemember = newValue;
        });
      },
      value: _isRemember,
      title: new Text('Remember me'),
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: Colors.blueAccent,
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.blueAccent),
        textAlign: TextAlign.right,
      ),
      onPressed: _launchURL,
    );

    final registrationLabel = FlatButton(
      child: Text(
        "Don't have an account?",
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.of(context).pushNamed('/RegistrationScreen');
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Login',
          textAlign: TextAlign.center,
        ),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 12.0),
            password,
            Stack(
              children: <Widget>[
                Align(
                  child: rememberMeCheckBox,
                  alignment: Alignment.centerLeft,
                ),
                Align(
                  child: forgotLabel,
                  alignment: Alignment.centerRight,
                )
              ],
            ),
            SizedBox(height: 24.0),
            loginButton,
            registrationLabel
          ],
        ),
      ),
    );
  }
}
