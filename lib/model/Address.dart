import 'dart:convert';

Address addressFromJson(String str) {
  final jsonData = json.decode(str);
  return Address.fromJson(jsonData);
}

String userToJson(Address data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Address {
  String emailId;
  String houseNumber;
  String streetName;

  String city;
  String state;
  String country;
  String pinCode;

  Address(
      {this.emailId,
      this.houseNumber,
      this.streetName,
      this.city,
      this.state,
      this.country,
      this.pinCode});

  factory Address.fromJson(Map<String, dynamic> json) => new Address(
        emailId: json["email_id"],
        houseNumber: json["house_number"],
        streetName: json["street_name"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        pinCode: json["pin_code"],
      );

  Map<String, dynamic> toJson() => {
        "email_id": emailId,
        "house_number": houseNumber,
        "street_name": streetName,
        "city": city,
        "state": state,
        "country": country,
        "pin_code": pinCode,
      };
}
