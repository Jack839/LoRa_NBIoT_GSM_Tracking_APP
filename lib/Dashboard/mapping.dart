

import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:lora_gpstracking2/Dashboard/gpsData1.dart';
import 'package:lora_gpstracking2/Dashboard/historyCordinates.dart';
import 'package:lora_gpstracking2/Dashboard/location_history.dart';
import 'package:lora_gpstracking2/Dashboard/testforsearch.dart';
import 'package:lora_gpstracking2/Login/loginUi.dart';
import 'package:lora_gpstracking2/services/locationapi..dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lora_gpstracking2/notifier/mapnotifier.dart';
import 'package:provider/provider.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
//import 'au';
class liveBusTrackingHome extends StatefulWidget {
  @override
  liveBusTrackingHomeState createState() => liveBusTrackingHomeState();
}

class liveBusTrackingHomeState extends State<liveBusTrackingHome> {
  Completer<GoogleMapController> _controller = Completer();
  double lat,long;
  //Record rec;
  Map<String, double> currentLocationValue = new Map();
  StreamSubscription<LocationData> locationSubscription;
  Location location = new Location();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  var prefs;

  @override
  void initState() {
    // TODO: implement initState
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context, listen: false);
//    getFoods(foodNotifier);
//    getCu
//    print('printing of values is here');
//    print(foodNotifier.foodList);
    //getInfo();
    print(foodNotifier.currentSelectedDevice.objectId);
    super.initState();


  }

//  getInfo()async{
//    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context);
//    prefs =  await SharedPreferences.getInstance();
//    print(foodNotifier.foodList);
//
//  }
//  void  _Userload() async {
//    print("Printing response is here");
//    var apiResponse = await ParseObject('mapping').getAll();
//
//    rec.lat= apiResponse.result['latitude'];
//    rec.long =apiResponse.result['longitude'];
//    print(rec.lat);
//    //return rec;
//
////    if (apiResponse.success){
////      for (var testObject in apiResponse.result) {
////        print( ": " + testObject.toString());
////      }
////    }
//  }

  @override
  Widget build(BuildContext context) {
    return
      //new WillPopScope(
//      onWillPop: () async{
////        SystemNavigator.pop();
////        return false;
//      },
     // child:
    Scaffold(
          appBar: AppBar(
            title: Text(
              "Device Tracking",
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.exit_to_app, color: Colors.teal,),
                onPressed: () async {
                  FlutterSecureStorage storage= await FlutterSecureStorage();
                  //deleting credential from local storage
                  await storage.delete(key: "password");
                  await storage.delete(key: "username1");
                  await storage.delete(key: "objectId");
                  await storage.deleteAll();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(
                          builder: (BuildContext ctx) => Login2()));
                },
              ),
            ],
          ),
          body: _buildGoogleMap(context)

    );
  }

  Widget _buildGoogleMap(BuildContext context, ) {
    //final record = gpsData.fromSnapshot(data);
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context);
    try{
      Marker currentLocationMarker = Marker(
        markerId: MarkerId("currentLocation"),
        infoWindow: InfoWindow(
            title: "Current Location",
            snippet: "Device Current location"),
        position: LatLng( foodNotifier.currentSelectedDevice.latitude,
            foodNotifier.currentSelectedDevice.longitude),

      );
      setState(() {

        markers[currentLocationMarker.markerId] = currentLocationMarker;

        setCamera(foodNotifier.currentSelectedDevice);
      });
    }catch(e){
    }
    return
//      new WillPopScope(
//      onWillPop: () async{
//        SystemNavigator.pop();
//        return false;
//      },
//      child:
      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Scaffold(


          body:GoogleMap(
            mapType: MapType.normal,
            //myLocationEnabled: true,
            myLocationButtonEnabled: true,
            initialCameraPosition:  CameraPosition(target: LatLng(foodNotifier.currentSelectedDevice.latitude,  foodNotifier.currentSelectedDevice.longitude), zoom: 17),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: Set<Marker>.of(markers.values),
          ),
          floatingActionButton: FloatingActionButton(

            child:Icon(Icons.history),
            backgroundColor: Colors.black87,
            onPressed: () async{
//              Navigator.push(
//                context,
//                MaterialPageRoute(
//                  builder: (context) => PlacePicker(
//                    apiKey: APIKeys.apiKey,   // Put YOUR OWN KEY here.
//                    onPlacePicked: (result) {
//                      print(result.address);
//                      Navigator.of(context).pop();
//                    },
//                    initialPosition: HomePage.kInitialPosition,
//                    useCurrentLocation: true,
//                  ),
//                ),
//              );
              Navigator.push(
                context,

                MaterialPageRoute(builder: (context) =>
                    //MyApp23(),
                  HistoryCoordiantes(),
                   // HistoryCoordiantes(lati: foodNotifier.currentSelectedDevice.latitude,longi: foodNotifier.currentSelectedDevice.longitude),
                ),
              );
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        ),

    );
  }



  Future<void> setCamera(final gData) async {
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context, listen: false);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(foodNotifier.currentSelectedDevice.latitude,foodNotifier.currentSelectedDevice.longitude), zoom: 17)));

  }
  void getInitialLocation(record) async {
    LocationData currentLocation = null;
//    prefs =  await SharedPreferences.getInstance();
//    lat = prefs.getDouble("latitude")??0;
//    long = prefs.getDouble("longitude")??0;
//    print(lat);
//    print(long);
//    print(record.latitude);
//    print(record.longitude);

//    if (record.latitude != lat || record.longitude != long) {
//      Firestore.instance.collection("history").add({
//        'coords': GeoPoint(record.latitude, record.longitude),
//      });
//      prefs.setDouble("latitude", record.latitude);
//      prefs.setDouble("longitude", record.longitude);
//    }


  }

}
//
//
//
//
//
//
//
//
//
//
//
//
//
//
////import 'dart:io';
////import 'dart:async';
////import 'package:flutter/material.dart';
////import 'package:google_maps_flutter/google_maps_flutter.dart';
//////import 'package:cloud_firestore/cloud_firestore.dart';
////import 'package:flutter/services.dart';
////import 'package:location/location.dart';
////import 'package:lora_gpstracking/Login/testingforparse.dart';
//////mport 'package:scratchnest_map/gpsData1.dart';
//////import 'package:scratchnest_map/location_history.dart';
////import 'package:shared_preferences/shared_preferences.dart';
////import 'package:parse_server_sdk/parse_server_sdk.dart';
////
////import 'gpsData1.dart';
////
////
////
////
////class liveBusTrackingHome extends StatefulWidget {
////  @override
////  liveBusTrackingHomeState createState() => liveBusTrackingHomeState();
////}
////
////class liveBusTrackingHomeState extends State<liveBusTrackingHome> {
////  Completer<GoogleMapController> _controller = Completer();
////  double lat,long;
////  Map<String, double> currentLocationValue = new Map();
////  StreamSubscription<LocationData> locationSubscription;
////  Location location = new Location();
////  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
////  var prefs;
////
////  @override
////  void initState() {
////    // TODO: implement initState
////    getInfo();
////    super.initState();
////
////
////  }
////
////  getInfo()async{
////    prefs =  await SharedPreferences.getInstance();
////
////  }
////
////  @override
////  Widget build(BuildContext context) {
////    return  new WillPopScope(
////      onWillPop: () async{
////        SystemNavigator.pop();
////        return false;
////      },
////      child:Scaffold(
////          appBar: AppBar(
////            title: Text(
////              "Device Tracking",
////            ),
////          ),
////          body: _buildBody(context)
////      ),
////    );
////  }
////  //docs.documents[i].data["location"]
////  Future getda()async{
////    print("here");
////    var apiResponse = await ParseObject('ParseTableName').getAll();
////    var dietPlan = await DietPlan().getObject('R5EonpUDWy');
////
////
////    if (apiResponse.success){
////      for (var testObject in apiResponse.result) {
////        print( testObject.toString());
////      }
////    }
////
////  }
////
////  Widget _buildBody(BuildContext context) {
////
//////    return StreamBuilder<QuerySnapshot>(
//////      stream: Firestore.instance.collection('mapping').snapshots(),
//////      builder: (context, snapshot) {
//////        if (!snapshot.hasData) return LinearProgressIndicator();
//////        return _buildGoogleMap(context, snapshot.data.documents[0]);
//////      },
//////
//////    );
////  getda();
////    return _buildGoogleMap();
////  }
////
////  Widget _buildGoogleMap() {
////    //final record = gpsData.fromSnapshot(data);
////    //getInitialLocation(record);
////
////
////    try{
////      Marker currentLocationMarker = Marker(
////        markerId: MarkerId("currentLocation"),
////        infoWindow: InfoWindow(
////            title: "Current Location",
////            snippet: "Device Current location"),
////        position: LatLng(
////            //record.latitude
////           30.678,
////          24.789
////          //  record.longitude
////        ),
////
////      );
////      setState(() {
////
////        markers[currentLocationMarker.markerId] = currentLocationMarker;
////
////        setCamera();
////      });
////    }catch(e){
////    }
////    return new WillPopScope(
////      onWillPop: () async{
////        SystemNavigator.pop();
////        return false;
////      },
////      child:Container(
////        height: MediaQuery.of(context).size.height,
////        width: MediaQuery.of(context).size.width,
////        child: Scaffold(
////
////
////          body:GoogleMap(
////            mapType: MapType.normal,
////            //myLocationEnabled: true,
////            myLocationButtonEnabled: true,
////            initialCameraPosition:  CameraPosition(target: LatLng(30.234, 28.789), zoom: 20),
////            onMapCreated: (GoogleMapController controller) {
////              _controller.complete(controller);
////            },
////            markers: Set<Marker>.of(markers.values),
////          ),
////          floatingActionButton: FloatingActionButton(
////
////            child:Icon(Icons.history),
////            backgroundColor: Colors.black87,
////            onPressed: () async{
////              Navigator.push(
////                context,
////
////                MaterialPageRoute(builder: (context) => Home(),),
////              );
////            },
////          ),
////          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
////        ),
////      ),
////    );
////  }
////
////
////
////  Future<void> setCamera() async {
////    final GoogleMapController controller = await _controller.future;
////    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(30.234, 28.789), zoom: 20)));
////
////  }
//////  void getInitialLocation(record) async {
//////    LocationData currentLocation = null;
//////    prefs =  await SharedPreferences.getInstance();
//////    lat = prefs.getDouble("latitude")??0;
//////    long = prefs.getDouble("longitude")??0;
//////    print(lat);
//////    print(long);
//////    print(record.latitude);
//////    print(record.longitude);
//////
//////    if (record.latitude != lat || record.longitude != long) {
//////      Firestore.instance.collection("history").add({
//////        'coords': GeoPoint(record.latitude, record.longitude),
//////      });
//////      prefs.setDouble("latitude", record.latitude);
//////      prefs.setDouble("longitude", record.longitude);
//////    }
//////
//////
//////  }
////
////}
//
//
//
//
//
