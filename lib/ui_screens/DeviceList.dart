import 'package:device_management_app/model/Device.dart';
import 'package:device_management_app/ui_screens/LoginScreen.dart';
import 'package:flutter/material.dart';

class DeviceListPage extends StatefulWidget {
  DeviceListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DeviceListPageState createState() => _DeviceListPageState();
}

class _DeviceListPageState extends State<DeviceListPage> {
  List devices;

  @override
  void initState() {
    // TODO: implement initState
    devices = getDevices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(Device device) => ListTile(

          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: Icon(Icons.important_devices, color: Colors.white),
          ),
          title: Text(
            device.title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

          subtitle: Row(
            children: <Widget>[
              Expanded(
                  flex: 3,
                  child: Container(
                    // tag: 'hero',
                    child: Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(device.OSName,
                            style: TextStyle(color: Colors.white))),
                  )),
              Expanded(
                flex: 5,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(device.OSVersion.toString(),
                        style: TextStyle(color: Colors.white))),
              )
            ],
          ),
          trailing: Wrap(
            spacing: 0.0,
            // gap between adjacent chips
            runSpacing: 0.0,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.bookmark_border,
                    color: Colors.white, size: 25.0),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.keyboard_arrow_right,
                    color: Colors.white, size: 25.0),
                onPressed: () {},
              ),
            ],
          ),

          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          },
        );

    Card makeCard(Device device) => Card(
      elevation: 4.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: makeListTile(device),
          ),
        );

    final makeBody = Container(
      decoration: BoxDecoration(color: Colors.white),
      child: ListView.builder(

        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: devices.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(devices[index]);
        },
      ),
    );


    return makeBody;




  }
}

List getDevices() {
  return [
    Device(
        title: "Samsung Galaxy S9",
        brand: 'Samsung',
        OSName: 'Android',
        OSVersion: 8.1,
        content: 'Very nice 6.7 inch display device'),
    Device(
        title: "Samsung Galaxy S8",
        brand: 'Samsung',
        OSName: 'Android',
        OSVersion: 8.1,
        content: 'Very nice 5.8 inch display device'),
    Device(
        title: "Samsung Galaxy S7",
        brand: 'Samsung',
        OSName: 'Android',
        OSVersion: 8.1,
        content: 'Very nice 5.8 inch display device'),
    Device(
        title: "iPhone 8 plus",
        brand: 'Apple',
        OSName: 'iOS',
        OSVersion: 10.3,
        content: 'Very nice 6.0 inch display device'),
    Device(
        title: "iPhone 8 ",
        brand: 'Apple',
        OSName: 'iOS',
        OSVersion: 10.3,
        content: 'Very nice 5.8 inch display device'),
    Device(
        title: "iPhone 7 plus",
        brand: 'Apple',
        OSName: 'iOS',
        OSVersion: 10.3,
        content: 'Very nice 6.0 inch display device'),
    Device(
        title: "iPad 2",
        brand: 'Apple',
        OSName: 'iOS',
        OSVersion: 10.3,
        content: 'Very nice 10 inch display device'),
    Device(
        title: "Lenevo Tablet",
        brand: 'Lenevo',
        OSName: 'Android',
        OSVersion: 7.1,
        content: 'Very nice 10 inch display device'),
  ];
}
