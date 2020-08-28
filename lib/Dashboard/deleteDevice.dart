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
import 'mapping.dart';

class DeleteDevice extends StatefulWidget {
  @override
  _DeleteDeviceState createState() => _DeleteDeviceState();
}

class _DeleteDeviceState extends State<DeleteDevice> {
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
                'Delete Devices'
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
                    FlutterSecureStorage storage = await FlutterSecureStorage();
                    var uid = await storage.read(key: 'objectId');
                    print('New Devices being add here');
                    foodNotifier.locationList.removeAt(index);
                    var deleteFromMapping = ParseObject('mapping')
                    ..objectId=cur.objectId
                    ..delete();
                    await deleteFromMapping.save();


                    QueryBuilder<ParseObject> queryPost =
                    QueryBuilder<ParseObject>(ParseObject('history'))
                      ..whereEqualTo('deviceId', cur.objectId);
                    var apiResponse = await queryPost.query();
                    var res=apiResponse.results[0]['objectId'];
                    print(cur.objectId);
                    print(res);
                    var deleteFromhistory = ParseObject('history')
                      ..objectId=res
                      ..delete();
                    await deleteFromhistory.save();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DeleteDevice()));
                    //var index1=apiResponse.results[0]['latestIndex'];
                   // print(index1);




//                      Navigator.push(
//                        context,
//
//                        MaterialPageRoute(builder: (context) => liveBusTrackingHome(),),
//                      );
                    //FoodDetail();
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
            MaterialPageRoute(builder: (context) => DeleteDevice(),),
          );
        },
      );
  }

}
