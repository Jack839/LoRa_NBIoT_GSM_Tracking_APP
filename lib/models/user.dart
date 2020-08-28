import 'package:parse_server_sdk/parse_server_sdk.dart';
class User {

  var username;
  var email;
  var objectId;


  User({this.username, this.email,this.objectId
  });


  User.fromJson(var json) {
    username = json['username'];
    email = json['email'];
    objectId=json['objectId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['uuid'] = this.uuid;
    data['username'] = this.username;
    data['email'] = this.email;
    data['objectId']=this.objectId;

    return data;
  }
}