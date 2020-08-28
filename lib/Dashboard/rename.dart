
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lora_gpstracking2/Dashboard/device_adder.dart';
import 'package:lora_gpstracking2/notifier/mapnotifier.dart';
import 'package:provider/provider.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:lora_gpstracking2/services/locationapi..dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'calender.dart';
import 'devicelist.dart';
import 'mapping.dart';




class Renamer extends StatefulWidget {
  @override
  _RenamerState createState() => _RenamerState();
}

class _RenamerState extends State<Renamer> {
  var prefs;
  Future<void> _getData() async {
//  setState(() {
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context);
    getLocationData(foodNotifier);
    // });
  }
  void initState() {
    // TODO: implement initState
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context, listen: false);
    getLocationData(foodNotifier);
    print('printing of values is here');
    print(foodNotifier.locationList);
    //getInfo();
    super.initState();


  }

  deleteDevices(){

  }
  getInfo()async{
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context);
    prefs =  await SharedPreferences.getInstance();
    print(foodNotifier.locationList);

  }
  @override
  Widget build(BuildContext context) {
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context);
    return
      RefreshIndicator(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
                'Rename Devices'
            ),
          ),
          body: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: foodNotifier.locationList.length,
            itemBuilder: (BuildContext context, int index) {
              // String key = foodNotifier.currentFood.tasks.keys.elementAt(index);
              return new Column(
                children: <Widget>[
                  Calender(ch:true,ch2:false,thisdate: foodNotifier.locationList[index],ontap:() async {


                    var cur=foodNotifier.locationList[index];
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  Renamer2(objectId: cur.objectId),),
                    );




                  },)

                ],
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=>DeviceAdder()));
            },
            elevation: 3,
            child: Icon(Icons.add),

          ),
        ),
        onRefresh:
        //_getData,
            () async{
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Renamer(),),
          );
        },
      );
  }

}


class Renamer2 extends StatefulWidget {
  var objectId;
  Renamer2({this.objectId});
  @override
  _Renamer2State createState() => _Renamer2State();
}

class _Renamer2State extends State<Renamer2> {
  double lat;
  double long;
  String name;
  final passController = TextEditingController();
  doTest()async{
    FlutterSecureStorage storage = await FlutterSecureStorage();
  }
  addDevice (var name) async{

    print('');
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context, listen: false);
    var index=foodNotifier.locationList.length;


    FlutterSecureStorage storage = await FlutterSecureStorage();
    var uid = await storage.read(key: 'objectId');


    print('Renamed Devices being add here');
    var newDevice = ParseObject('mapping')..objectId=widget.objectId
      ..set('deviceName', name);
    await newDevice.save();
    print(newDevice.objectId);
    //adding the row
    Navigator.push(context, MaterialPageRoute(builder: (context)=>DeviceList()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rename"),
      ),
      body: Column(
        children: [
          TextField(
            onChanged:(value){
              name=value;
            } ,
            decoration: InputDecoration(
                hintText: 'Add New Name'
            ),
          ),

          FlatButton(
            child: Text('Add Device'),
            onPressed: () {
              addDevice(name);
            },
          ),
//          FlatButton(
//            child: Text('testing button'),
//            onPressed: () {
//              doTest();
//            },
//          ),
        ],
      ),
    );
  }
}




