//import 'package:lora_gpstracking//models/article.dart';
import 'package:flutter/material.dart';
class Mapping{
    String objectId;
    var  latitude;
    //var updatedAt;
    var longitude;
    var uid;
    var createdAt;
    var index;
    var deviceName;

     Mapping({
      this.objectId,
      this.latitude,
      // this.updatedAt,
       this.longitude,
       this.createdAt,
       this.index,
       this.deviceName,
       });
     Mapping.fromJson(var json){
        objectId=json['objectId'];
        latitude=json['latitude'];
        //updatedAt=json['updatedAt'];
        longitude=json['longitude'];
        createdAt=json['createdAt'];
        index=json['index'];
        deviceName=json['deviceName'];
     }

    Map<String, dynamic> toJson() {
      //final Map data = new Map();
      var data;
      data['objectId']=this.objectId;
      data['latitude']=this.latitude;
     // data['updatedAt']=this.updatedAt;
      data['longitude']=this.longitude;
      data['createdAt']=this.createdAt;
      data['index']=this.index;
      data['deviceName']=this.deviceName;
      return data;
    }


}