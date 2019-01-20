import 'dart:async';
import 'dart:io';

import 'package:device_management_app/model/Address.dart';
import 'package:device_management_app/model/User.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "DeviceDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE User ("
          "user_name TEXT,"
          "full_name TEXT,"
              "email_id TEXT PRIMARY KEY,"
          "mobile_number TEXT,"
          "password TEXT,"
              "disabled Text"
              ")");
          await db.execute("CREATE TABLE Address ("
              "email_id TEXT PRIMARY KEY,"
              "house_number TEXT ,"
              "street_name TEXT,"
              "city TEXT,"
              "state TEXT,"
              "country Text"
              "pin_code Text"
          ")");
    });
  }

  newAddress(Address newAddress) async {
    final db = await database;
    var raw = await db.rawInsert(
        "INSERT Into Address (email_id,house_number,street_name,city,state,country,pin_code)"
            " VALUES (?,?,?,?,?,?,?)",
        [
          newAddress.emailId,
          newAddress.houseNumber,
          newAddress.streetName,
          newAddress.city,
          newAddress.state,
          newAddress.country,
          newAddress.pinCode
        ]);
    return raw;
  }

  updateAddress(Address newAddress) async {
    final db = await database;
    var res = await db.update("Address", newAddress.toJson(),
        where: "email_id = ?", whereArgs: [newAddress.emailId]);
    return res;
  }

  deleteAddress(String emailId) async {
    final db = await database;
    return db.delete("Address", where: "email_id = ?", whereArgs: [emailId]);
  }

  getAddress(String emailId) async {
    final db = await database;
    var res =
    await db.query("Address", where: "email_id = ?", whereArgs: [emailId]);
    return res.isNotEmpty ? Address.fromJson(res.first) : null;
  }

  newUser(User newUser) async {
    final db = await database;
    //get the biggest id in the table
//    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM User");
//    int id = table.first["id"];
//    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into User (user_name,full_name,email_id,mobile_number,password,disabled)"
            " VALUES (?,?,?,?,?,?)",
        [
          newUser.userName,
          newUser.fullName,
          newUser.emailId,
          newUser.mobileNumber,
          newUser.password,
          newUser.disabled
        ]);
    return raw;
  }

  enableOrDisable(User user) async {
    final db = await database;
    User disabled = User(
        userName: user.userName,
        fullName: user.fullName,
        emailId: user.emailId,
        mobileNumber: user.mobileNumber,
        password: user.password,
        disabled: user.disabled);

    var res = await db.update("User", disabled.toJson(),
        where: "email_id = ?", whereArgs: [user.emailId]);
    return res;
  }

  updateUser(User newUser) async {
    final db = await database;
    var res = await db.update("User", newUser.toJson(),
        where: "email_id = ?", whereArgs: [newUser.emailId]);
    return res;
  }

  getUser(String id) async {
    final db = await database;
    var res = await db.query("User", where: "email_id = ?", whereArgs: [id]);
    return res.isNotEmpty ? User.fromJson(res.first) : null;
  }

  Future<List<User>> getDisabledUsers() async {
    final db = await database;

    print("works");
    // var res = await db.rawQuery("SELECT * FROM Client WHERE blocked=1");
    var res = await db.query("User", where: "disabled = ? ", whereArgs: [1]);

    List<User> list =
        res.isNotEmpty ? res.map((c) => User.fromJson(c)).toList() : [];
    return list;
  }

  Future<List<User>> getAllUsers() async {
    final db = await database;
    var res = await db.query("User");
    List<User> list =
        res.isNotEmpty ? res.map((c) => User.fromJson(c)).toList() : [];
    return list;
  }

  deleteUser(String id) async {
    final db = await database;
    return db.delete("User", where: "email_id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from User");
  }
}
