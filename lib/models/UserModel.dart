// ignore: file_names
import 'package:disaster_management_app/enum/UserTypes.dart';

class User {
  String? name;
  String? email;
  String? phonenumber;
  UserType? userType;

  User({this.name, this.email, this.phonenumber, this.userType});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phonenumber = json['phone_number'];
    userType = UserType.values
        .firstWhere((element) => element.toString() == json['userType']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone_number'] = phonenumber;
    data['userType'] = userType;
    return data;
  }
}
