import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lora_gpstracking2/Dashboard/location_history.dart';
import 'package:lora_gpstracking2/notifier/mapnotifier.dart';
import 'package:provider/provider.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:lora_gpstracking2/services/locationapi..dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'calender.dart';
import 'mapping.dart';

class HistoryCoordiantes extends StatefulWidget {
  @override
  _HistoryCoordiantesState createState() => _HistoryCoordiantesState();
}

class _HistoryCoordiantesState extends State<HistoryCoordiantes> {
  var prefs;
  List cordArr;
  List cordArr2;

  Future<void> _getData() async {
//  setState(() {
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context);
    getLocationData(foodNotifier);
    // });
  }
  void initState() {
    // TODO: implement initState
    getInfo();
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context, listen: false);
    getLocationData(foodNotifier);
    print('printing of values is here');
    print(foodNotifier.locationList);
    //getInfo();
    super.initState();


  }

  getInfo()async{
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context);
    QueryBuilder<ParseObject> queryPost2 =
    QueryBuilder<ParseObject>(ParseObject('history'))
      ..whereEqualTo('deviceId', foodNotifier.currentSelectedDevice.objectId);

    var apiResponse12 = await queryPost2.query();
    print(apiResponse12);
    cordArr=apiResponse12.result[0]['location'];
    if(cordArr==null)
      {
       // cordArr=[foodNotifier.currentSelectedDevice.latitude,foodNotifier.currentSelectedDevice.longitude];
       // cordArr[1]=foodNotifier.currentFood.longitude;
        cordArr=["No history Found"," "];
        //cordArr[1]="null";
      }
    ;
  }
  @override
  Widget build(BuildContext context) {
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context);
    getInfo();
    return

        RefreshIndicator(
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                  'History Location List'
              ),
            ),
            body:(cordArr[0]=="No history Found")?Text('No History Found'):
            ListView(
              scrollDirection: Axis.vertical,
//              itemCount: cordArr.length,
//              itemBuilder: (BuildContext context, int index) {
//                // String key = foodNotifier.currentFood.tasks.keys.elementAt(index);
//                return new
               // Column(
                  children: <Widget>[
                    for(int i=0;i<cordArr.length-1;i=i+2)
                    GestureDetector(
                      onTap:
                          () async{
                        Navigator.push(
                          context,

                          MaterialPageRoute(builder: (context) =>
                              //HistoryCoordiantes(),
                             HistoryTrack(lati: cordArr[i],longi:  cordArr[i+1],id:foodNotifier.currentSelectedDevice.objectId,arr:cordArr),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.916,
                              height: MediaQuery.of(context).size.height * 0.09,
                              child: Material(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                      style: BorderStyle.solid,
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: (true)?Column(
                                    children: <Widget>[

                                      Container(
                                        alignment: Alignment.center,
                                        width: MediaQuery.of(context).size.width * 0.125,
                                        child: Icon(Icons.device_hub),
                                      ),
                                      Text("Cordiantes\n"+cordArr[i].toString()+" "+cordArr[i+1].toString(),style: TextStyle(
                                        fontSize: 14,
                                      ),),
                                    ],
                                  ):Column(
                                    children: <Widget>[
                                      Text(" ",style: TextStyle(
                                        fontSize: 14,
                                      ),),
                                    ],
                                  )

                              ),
                            ),
                          ],
                        ),
                      ),
                    )


                  ],
               // );
               // index=index+2;
             // },
            ),
          ),
          onRefresh:
          //_getData,
              () async{
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HistoryCoordiantes(),),
            );
          },

        //FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context),
      );
  }

}
