
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lora_gpstracking2/models/courseSection.dart';

import 'package:lora_gpstracking2/models/record..dart';
import 'package:lora_gpstracking2/models/user.dart';
import 'package:lora_gpstracking2/notifier/authnotifier.dart';
import 'package:lora_gpstracking2/notifier/mapnotifier.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:provider/provider.dart';
import 'package:lora_gpstracking2/notifier/authnotifier.dart';

//******** ********
//The above design is used for wirting the functionality
getLocationData(FoodNotifier foodNotifier) async {

print("latest testing is being done here");

  List<Mapping> _foodList = [];
  FlutterSecureStorage storage = await FlutterSecureStorage();
  //******** picking the all devices linked to login account ********
  var uid = await storage.read(key: 'objectId');
  QueryBuilder<ParseObject> queryPost =
  QueryBuilder<ParseObject>(ParseObject('mapping'))
    ..whereEqualTo('uid', uid);
  //******** For debugging ********
  //print('current query is here');
  var apiResponse = await queryPost.query();
  //print( apiResponse.result[2]);

  apiResponse.result.forEach((document) {
    //******** getting all devices and putting it inside the list ********
    Mapping tempLocation = Mapping.fromJson(document);
      //print(tempLocation.latitude);
    _foodList.add(tempLocation);
  });
  foodNotifier.locationList = _foodList;
  //print(_foodList[0]);


//******** Live query for instant location update and creating history track********
  final LiveQuery liveQuery = LiveQuery();
  Subscription subscription = await liveQuery.client.subscribe(queryPost);
  subscription.on(LiveQueryEvent.update, (value) async {

  print('live values are here');
  print((value as ParseObject));

  //******** Latest updated device********
  Mapping latestUpdatedDevice = Mapping.fromJson(value as ParseObject);

  //for history
  QueryBuilder<ParseObject> queryPost2 =
  QueryBuilder<ParseObject>(ParseObject('history'))
    ..whereEqualTo('deviceId', latestUpdatedDevice.objectId);

  var apiResponse12 = await queryPost2.query();
  print("for history");
  print(apiResponse12.result[0]['objectId']);
  //adding value in history



  print(latestUpdatedDevice.index);
  var p =  foodNotifier.locationList.firstWhere((e) => e.index == latestUpdatedDevice.index);
  print(p.index);
  var ingh=foodNotifier.locationList.indexOf(p);
  print(ingh);

  //adding value in history
  var dietPlan = ParseObject('history')
      ..objectId = apiResponse12.results[0]['objectId']
      ..add('location', [foodNotifier.locationList[ingh].latitude,foodNotifier.locationList[ingh].longitude]);
    await dietPlan.save();


  foodNotifier.locationList[ingh]=latestUpdatedDevice;
  print(foodNotifier.locationList[ingh].objectId);
  if(latestUpdatedDevice.index==foodNotifier.currentSelectedDevice.index)
  {
    foodNotifier.currentSelectedDevice=latestUpdatedDevice;
  }

  });

}






//  var apiResponse2 = await ParseObject('mapping').getObject('bZH16mFjOk');


//  _foodList.add(apiResponse2.result['latitude']);
//  _foodList.add(apiResponse2.result['longitude']);
// // print(_foodList);
//FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context, listen: false);




//    QueryBuilder<ParseObject> queryPost2 =
//    QueryBuilder<ParseObject>(ParseObject('mapping'))
//      ..whereEqualTo('uid', 'djjdfasldkfjhas');
//    List<CourseSection> _foodList = [];
//    var apiResponse2 = await queryPost2.query();
//    print( apiResponse2.result[2]);

//  authNotifier.user.objectId;
//  print("chwecking auth notifier");
//  print(authNotifier.user.objectId);


//print( "new values data"+apiResponse2.result[2]);
//  apiResponse.result.forEach((document) {
//
//    print(document);
//    CourseSection food = CourseSection.fromJson(document);
//    i++;
//    print(food.latitude);
//    //print(food.longitude+" "+food.latitude+"\n");
//    _foodList2.add(food);
//  });
// foodNotifier.foodList = _foodList2;
//print(_foodList2[0]);
//
//  print(food.latitude);


//    value.result.forEach((document) {
//      //print(document);
//      CourseSection food = CourseSection.fromJson(document);
//      print(food.latitude);
//      //print(food.longitude+" "+food.latitude+"\n");
//      _foodList.add(food);
//    });
//    foodNotifier.foodList.clear();
//    foodNotifier.foodList = _foodList;
//    print(_foodList[0]);
//


//    var dietPlan = ParseObject('history')
//      ..objectId = 'NG997zQS7e'
//      ..add('location', [foodNotifier.foodList[0],foodNotifier.foodList[1]]);
//    await dietPlan.save();
//    _foodList[0]=(value as ParseObject).get('latitude');
//    _foodList[1]=(value as ParseObject).get('longitude');
//    foodNotifier.foodList = _foodList;
