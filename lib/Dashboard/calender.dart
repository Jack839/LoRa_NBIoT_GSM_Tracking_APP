import 'package:flutter/material.dart';
import 'package:lora_gpstracking2/models/courseSection.dart';

class Calender extends StatefulWidget {
  @override
  bool ch;
  bool ch2;
  Function ontap;
  Mapping thisdate;
  Calender({this.ch,this.ch2,this.thisdate,this.ontap});
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  bool boole1;
  bool boole2;

  DateTime dateTime=new DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getfuc();
  }
  getfuc(){
    boole1=widget.ch;
    boole2=widget.ch2;
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.ontap,
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
                child: (boole1)?Column(
                  children: <Widget>[

                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.125,
                      child:
                      (boole2)?Icon(Icons.check ):Icon(Icons.device_hub),
                    ),
                    Text("DeviceName: "+(widget.thisdate.deviceName).toString()+"\nDeviceId: "+widget.thisdate.objectId.toString(),style: TextStyle(
                      fontSize: 14,
                    ),),
                  ],
                ):Column(
                  children: <Widget>[
                    Text(widget.thisdate.toString(),style: TextStyle(
                      fontSize: 14,
                    ),),
                  ],
                )

              ),
            ),
          ],
        ),
      ),
    );
  }
}
