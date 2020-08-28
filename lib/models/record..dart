import 'package:parse_server_sdk/parse_server_sdk.dart';
class Record {
  double latitude;
  double longitude;

  Record({this.latitude, this.longitude
  });


  Record.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['uuid'] = this.uuid;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;

    return data;
  }
}
//
//}
//
//
//class Record extends ParseObject implements ParseCloneable {
//
//  Record() : super(_keyTableName);
//  Record.clone(): this();
//
//  /// Looks strangely hacky but due to Flutter not using reflection, we have to
//  /// mimic a clone
//  @override clone(Map map) => Record.clone()..fromJson(map);
//
//  static const String _keyTableName = 'mapping';
//  static const String keyName1 = 'longitude';
//  static const String keyName2 = 'latitude';
//
//  double get lat => get<double>(keyName1);
//  set lat(double lat) => set<double>(keyName1, lat);
//  double get long => get<double>(keyName2);
//  set long(double long) => set<double>(keyName2, long);
//}
////
////
////class DietPlan extends ParseObject implements ParseCloneable {
////
////  DietPlan() : super(_keyTableName);
////  DietPlan.clone(): this();
////
////  /// Looks strangely hacky but due to Flutter not using reflection, we have to
////  /// mimic a clone
////  @override clone(Map map) => DietPlan.clone()..fromJson(map);
////
////  static const String _keyTableName = 'Diet_Plans';
////  static const String keyName = 'Name';
////
////  String get name => get<String>(keyName);
////  set name(String name) => set<String>(keyName, name);
////