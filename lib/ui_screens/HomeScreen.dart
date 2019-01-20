import 'package:device_management_app/ui_screens/AddressFragment.dart';
import 'package:device_management_app/ui_screens/RegistrationScreen.dart';
import 'package:device_management_app/ui_screens/common/left_drawer/DrawerItem.dart';
import 'package:flutter/material.dart';

import './DeviceList.dart';

class HomeScreen extends StatefulWidget {

  final drawerItems = [
    new DrawerItem("Device List", Icons.important_devices),
    new DrawerItem("My Fav", Icons.bookmark),
    new DrawerItem("Profile", Icons.account_box),
    new DrawerItem("Users", Icons.view_list),
    new DrawerItem("Settings", Icons.settings),
    new DrawerItem("Sign out", Icons.arrow_back)
  ];


  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new DeviceListPage(title: 'Devices');
      case 1:
        return new AddressFragment();
      case 2:
        return new RegistrationScreen();

      default:
        return new Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }


  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
          new ListTile(
            leading: new Icon(d.icon),
            title: new Text(d.title),
            selected: i == _selectedDrawerIndex,
            onTap: () => _onSelectItem(i),
          )
      );
    }

    final makeBottom = Container(
      height: 55.0,
      child: BottomAppBar(
        color: Color.fromRGBO(58, 66, 86, 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.assignment_ind, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.store, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.settings, color: Colors.white),
              onPressed: () {},
            )
          ],
        ),
      ),
    );

    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Colors.lightBlue,
      title: new Text(widget.drawerItems[_selectedDrawerIndex].title),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.bookmark),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.add_to_queue),
          onPressed: () {},
        )
      ],
    );


    return new MaterialApp(
      title: 'Home Screen',
      theme: new ThemeData(
          primaryColor: Color.fromRGBO(58, 66, 86, 1.0), fontFamily: 'Raleway'),
      home: new Scaffold(

        appBar: topAppBar,
        drawer: new Drawer(
          child: new Column(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                  accountName: new Text("Jay Dwivedi"), accountEmail: null),
              new Column(children: drawerOptions)
            ],
          ),
        ),
        body: _getDrawerItemWidget(_selectedDrawerIndex),
        bottomNavigationBar: makeBottom,
      ),

      // home: DetailPage(),
    );
  }
}
