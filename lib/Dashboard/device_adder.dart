import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lora_gpstracking2/Dashboard/devicelist.dart';
import 'package:lora_gpstracking2/notifier/mapnotifier.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:provider/provider.dart';
import 'package:lora_gpstracking2/models/courseSection.dart';
class DeviceAdder extends StatefulWidget {
  @override
  _DeviceAdderState createState() => _DeviceAdderState();
}

class _DeviceAdderState extends State<DeviceAdder> {
double lat;
  double long;
  String name;
  final passController = TextEditingController();
  doTest()async{
    FlutterSecureStorage storage = await FlutterSecureStorage();
    var uid = await storage.read(key: 'objectId');
    var newDevice = ParseObject('indexMaintain')
    ..create()
      ..set('latestIndex', '12');
    await newDevice.save();
  }
  addDevice (var lat, var long,var name) async{

    print('');
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context, listen: false);
    var index=foodNotifier.locationList.length;


    FlutterSecureStorage storage = await FlutterSecureStorage();
    var uid = await storage.read(key: 'objectId');

    QueryBuilder<ParseObject> queryPost =
    QueryBuilder<ParseObject>(ParseObject('indexMaintain'))
      ..whereEqualTo('deviceId', uid);
    var apiResponse = await queryPost.query();
    var res=apiResponse.results[0]['objectId'];
    var index1=apiResponse.results[0]['latestIndex'];
    print(index1);


    var setIndexField=ParseObject('indexMaintain')..objectId=res..set('latestIndex', (int.parse(index1)+1).toString());
    setIndexField.save();
    print(setIndexField.toString());
    print('New Devices being add here');
    var newDevice = ParseObject('mapping')
      ..set('longitude', long)
      ..set('uid', uid)
         ..set('deviceName', name)
      ..set('index',index1.toString())
      ..set('latitude', lat);
    await newDevice.save();
    print(newDevice.objectId);
    //adding the row
    var newDeviceHistory = ParseObject('history')
      ..set('deviceId', newDevice.objectId);

    //add index to index table

    await newDeviceHistory.save();
    print(newDeviceHistory.objectId);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>DeviceList()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Device"),
      ),
      body: Column(
        children: [
          TextField(
            onChanged:(value){
              name=value;
            } ,
            decoration: InputDecoration(
                hintText: 'Add Name'
            ),
          ),
          TextField(
            keyboardType: TextInputType.number,
            onChanged:(value){
              lat=double.parse(value);
            } ,
            decoration: InputDecoration(
                hintText: 'Add Latitude'
            ),
          ),
          TextField(
            keyboardType: TextInputType.number,
            onChanged:(value){
              long=double.parse(value);
            } ,
            decoration: InputDecoration(
                hintText: 'Add Longitude'
            ),
          ),
//          TextField(
//            controller: passController,
//            decoration: InputDecoration(
//                hintText: 'Pass'
//            ),
//          ),
          FlatButton(
            child: Text('Add Device'),
            onPressed: () {
              addDevice(lat, long,name
                  //emailController.text
              );
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
