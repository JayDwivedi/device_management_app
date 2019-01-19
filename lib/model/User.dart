import 'dart:convert';

User userFromJson(String str) {
  final jsonData = json.decode(str);
  return User.fromJson(jsonData);
}

String userToJson(User data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class User {
  int id;
  String userName;
  String fullName;
  String emailId;
  String mobileNumber;
  String password;
  String disabled;

  User({
    this.id,
    this.userName,
    this.fullName,
    this.emailId,
    this.mobileNumber,
    this.password,
    this.disabled,
  });

  factory User.fromJson(Map<String, dynamic> json) => new User(
        id: json["id"],
        userName: json["user_name"],
        fullName: json["full_name"],
        emailId: json["email_id"],
        mobileNumber: json["mobile_number"],
        password: json["password"],
        disabled: json["disabled"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_name": userName,
        "full_name": fullName,
        "email_id": emailId,
        "mobile_number": mobileNumber,
        "password": password,
        "disabled": disabled,
      };
}
