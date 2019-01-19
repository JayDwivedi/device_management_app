import 'package:flutter/material.dart';

class AddressScreen extends StatefulWidget {
  static String tag = 'address-page';

  @override
  _AddressPageState createState() => new _AddressPageState();
}

class _AddressPageState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    final houseNumber = TextFormField(
      keyboardType: TextInputType.number,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'House/Flat No.',
        labelText: 'House/Flat No.',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
    );

    final streetName = TextFormField(
      autofocus: false,
      obscureText: false,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: 'Street name',
        labelText: 'Street name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
    );
    final city = TextFormField(
      autofocus: false,
      obscureText: false,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: 'City',
        labelText: 'City',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
    );
    final state = TextFormField(
      autofocus: false,
      obscureText: false,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: 'State',
        labelText: 'State',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
    );
    final pinCode = TextFormField(
      autofocus: false,
      obscureText: false,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: 'Pin code',
        labelText: 'Pin code',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
    );
    final country = TextFormField(
      autofocus: false,
      obscureText: false,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: 'Country',
        labelText: 'Country',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
    );

    final addAddressButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          Navigator.of(context).pushReplacementNamed('/HomeScreen');
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Add address', style: TextStyle(color: Colors.white)),
      ),
    );

    final skipLabel = FlatButton(
      child: Text(
        "Skip",
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.of(context).pushReplacementNamed('/HomeScreen');
      },
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Add Address',
          textAlign: TextAlign.center,
        ),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            houseNumber,
            SizedBox(height: 8.0),
            streetName,
            SizedBox(height: 8.0),
            city,
            SizedBox(height: 8.0),
            state,
            SizedBox(height: 8.0),
            country,
            SizedBox(height: 8.0),
            pinCode,
            SizedBox(height: 24.0),
            addAddressButton,
            skipLabel
          ],
        ),
      ),
    );
  }
}
