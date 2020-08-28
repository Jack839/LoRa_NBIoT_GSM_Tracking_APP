import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';
import 'package:parse_server_sdk/parse_server_sdk.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
var random = new Random();


class HistoryTrack extends StatefulWidget {
  double lati;
  double longi;
  var id;
  var arr;
  HistoryTrack({
    this.lati,
    this.longi,
    this.id,
    this.arr,
  });

  @override
  State<HistoryTrack> createState() => HistoryTrackState(lati,longi);
}

class HistoryTrackState extends State<HistoryTrack> {
   double lati;
  HistoryTrackState(latit,longit);
  //inal Firestore _database = Firestore.instance;
  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  int counter;
  @override
  void initState() {
    crearmarcadores();
    print(widget.lati);
    print(widget.longi);
    initMarker(widget.lati, widget.longi,(widget.longi+random.nextInt(10000)));
    super.initState();
  }

  crearmarcadores() async {
//    QueryBuilder<ParseObject> queryPost2 =QueryBuilder<ParseObject>(ParseObject('history'))
//      ..whereEqualTo('deviceId', widget.id);
//    //var apiResponse12 = await queryPost2.query();
//    var apiResponse12 = await queryPost2.query();
//    var response= apiResponse12.result;
    var response=widget.arr;
    print(response.length);
      if (response!=null) {
        for (int i = 0; i < response.length-1; i=i+2) {

          initMarker(response[i], response[i+1],(response[i+1]+random.nextInt(10000)));
        }
      }
  }

  void initMarker(lat,long, lugaresid) async{
    var markerIdVal = lugaresid;
    final MarkerId markerId = MarkerId(markerIdVal.toString());
    final icon1 = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(24, 24)), 'assets/bluecircle.png');


    // creating a new MARKER
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(lat, long),
      infoWindow: InfoWindow(title: "Location", snippet: "History of Location"),
      icon: icon1,
    );

    // creating a new MARKER
    final Marker marker2 = Marker(
      markerId: markerId,
      position: LatLng(lat, long),
      infoWindow: InfoWindow(title: "Location", snippet: "History of Location"),
      icon: icon1,
    );

    setState(() {
      // adding a new marker to map
      markers[markerId] = marker;
    });
  }

//
//   CameraPosition _initial = CameraPosition(
//    target: LatLng(lati,widget.longi),
//    zoom: 16.0,
//  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(

        mapType: MapType.normal,
        initialCameraPosition:CameraPosition(
          target: LatLng(widget.lati,widget.longi),
          zoom: 20.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        myLocationEnabled: true,
        markers: Set<Marker>.of(markers.values),
      ),
    );
  }
}