////import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
//
//class gpsData {
//   double latitude;
//   double longitude;
//  //final DocumentReference reference;
//   gpsData({
//     this.latitude,
//     this.longitude,
//});
//
//  gpsData.fromJson(Map<String, dynamic> json){
//    latitude=json['longtude'];
//    longitude=json['latitude'];
//  }
//
//  Map<String,dynamic> toJson(){
//    final Map<String,dynamic>
//  }
//}
//
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
////  static const String _keyTableName = 'mapping';
////  //  static const String latitude = 'latitude';
//////  static const String longitude = 'longitude';
////
////  static const String keyName1 = 'latitude';
////  static const String keyName2 = 'longitude';
////
////  String get latitude => get<String>(keyName1);
////  set latitude(String latitude) => set<String>(keyName1, latitude);
////  String get longitude => get<String>(keyName1);
////  set longitude(String latitude) => set<String>(keyName1, latitude);
////}

class DietPlan extends ParseObject implements ParseCloneable {

  DietPlan() : super(_keyTableName);
  DietPlan.clone(): this();

  /// Looks strangely hacky but due to Flutter not using reflection, we have to
  /// mimic a clone
  @override clone(Map map) => DietPlan.clone()..fromJson(map);

  static const String _keyTableName = 'Diet_Plans';
  static const String keyName = 'Name';

  String get name => get<String>(keyName);
  set name(String name) => set<String>(keyName, name);
}
