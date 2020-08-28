import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lora_gpstracking2/Dashboard/device_adder.dart';
import 'package:lora_gpstracking2/Dashboard/rename.dart';
import 'package:lora_gpstracking2/notifier/mapnotifier.dart';
import 'package:provider/provider.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:lora_gpstracking2/services/locationapi..dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'calender.dart';
import 'deleteDevice.dart';
import 'mapping.dart';

class DeviceList extends StatefulWidget {
  @override
  _DeviceListState createState() => _DeviceListState();
}

class _DeviceListState extends State<DeviceList> {
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

  getInfo()async{
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context);
    prefs =  await SharedPreferences.getInstance();
    print(foodNotifier.locationList);

  }
  @override
  Widget build(BuildContext context) {
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context);
    var len=foodNotifier.locationList.length;
    if(len==null)
      {
        len=0;
      }
    return
      new WillPopScope(
      onWillPop: () async{
        SystemNavigator.pop();
        return false;
      },
    child:
      RefreshIndicator(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Device List'
          ),
        ),
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.70,
              child: ListView.builder(
                scrollDirection: Axis.vertical,

                itemCount: len,
                //foodNotifier.locationList.length,
                itemBuilder: (BuildContext context, int index) {
                  // String key = foodNotifier.currentFood.tasks.keys.elementAt(index);
                  return Calender(ch:true,ch2:false,thisdate: foodNotifier.locationList[index],ontap:(){
                    foodNotifier.currentSelectedDevice = foodNotifier.locationList[index];

                    print(foodNotifier.currentSelectedDevice.index);
                    print(foodNotifier.currentSelectedDevice.objectId);
                    Navigator.push(
                      context,

                      MaterialPageRoute(builder: (context) => liveBusTrackingHome(),),
                    );
                    //FoodDetail();
                  },);
                },
              ),
            ),
            Row(
              children: [
                SizedBox(width: 40,),
                Container(
                  color:Colors.yellow,
                  child: FlatButton(
                    child:Text('delete'),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>DeleteDevice()));
                    },
                  ),
                ),
                SizedBox(width: 40,),
                Container(
                  color:Colors.yellow,
                  child: FlatButton(
                    child:Text('RenameDevices'),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Renamer()));
                    },
                  ),
                ),
              ],
            ),
          ],
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
          MaterialPageRoute(builder: (context) => DeviceList(),),
        );
      },
      ),
      //FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context),
    );
  }

}
