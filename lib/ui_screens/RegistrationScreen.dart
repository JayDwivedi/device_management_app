import 'package:device_management_app/data_base/Database.dart';
import 'package:device_management_app/model/User.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({Key key}) : super(key: key);

  static String tag = 'registration-page';

  @override
  _RegistrationPageState createState() => new _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  TextEditingController userNameController = new TextEditingController();
  TextEditingController fullNameController = new TextEditingController();
  TextEditingController emailIdController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  TextEditingController mobileNoController = new TextEditingController();

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

    final userName = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: userNameController,
      validator: validateName,
      onSaved: (String val) {
        userNameController.text = val;
      },
      //initialValue: 'jaidwivedi21@gmail.com',
      decoration: InputDecoration(
        hintText: 'Username',
        //labelText: 'Username',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final fullName = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: fullNameController,
      validator: validateName,
      onSaved: (String val) {
        fullNameController.text = val;
      },
      //initialValue: 'jaidwivedi21@gmail.com',
      decoration: InputDecoration(
        hintText: 'Full Name',
        // labelText: 'Full Name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: emailIdController,
      validator: validateEmail,
      onSaved: (String val) {
        emailIdController.text = val;
      },
      //initialValue: 'jaidwivedi21@gmail.com',
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final mobile = TextFormField(
      keyboardType: TextInputType.phone,
      autofocus: false,
      controller: mobileNoController,
      validator: validateMobile,
      onSaved: (String val) {
        mobileNoController.text = val;
      },
      //initialValue: 'jaidwivedi21@gmail.com',
      decoration: InputDecoration(
        hintText: 'Mobile',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      controller: passwordController,

      //initialValue: '12345678',
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        //labelText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final confirmPassword = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: confirmPasswordController,
      validator: validatePassword,
      onSaved: (String val) {
        confirmPasswordController.text = val;
      },
      decoration: InputDecoration(
        hintText: 'Confirm Password',
        //labelText: 'Confirm Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final registrationButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: _validateInputs,
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Register', style: TextStyle(color: Colors.white)),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Sign up',
          textAlign: TextAlign.center,
        ),
      ),
      body: Center(
        child: new Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              logo,
              SizedBox(height: 48.0),
              userName,
              SizedBox(height: 8.0),
              fullName,
              SizedBox(height: 8.0),
              email,
              SizedBox(height: 8.0),
              mobile,
              SizedBox(height: 8.0),
              password,
              SizedBox(height: 8.0),
              confirmPassword,
              SizedBox(height: 24.0),
              registrationButton,
            ],
          ),
        ),
      ),
    );
  }

  String validatePassword(String value) {
    if (passwordController.text != value) return "Password must be same";

    return null;
  }

  String validateName(String value) {
    if (value.length < 4) return 'Name must be more than 3 charater';

    return null;
  }

  String validateMobile(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length != 10) return 'Mobile Number must be of 10 digit';

    return null;
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) return 'Enter Valid Email';

    return null;
  }

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();
      saveDataInDatabase().then((onValue) {
        if (onValue)
          Navigator.of(context).pushReplacementNamed('/AddressScreen');
      });
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }

  Future<bool> saveDataInDatabase() async {
    User newUser = User(
        userName: userNameController.text,
        fullName: fullNameController.text,
        emailId: emailIdController.text,
        mobileNumber: mobileNoController.text,
        password: confirmPasswordController.text,
        disabled: false);

    await DBProvider.db.newUser(newUser);

    setState(() {});
    return true;
  }
}
