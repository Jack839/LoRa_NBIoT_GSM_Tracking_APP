import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lora_gpstracking2/Dashboard/gpsData1.dart';
import 'package:lora_gpstracking2/models/courseSection.dart';
import 'package:lora_gpstracking2/models/record..dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:lora_gpstracking2/notifier/mapnotifier.dart';
import 'package:provider/provider.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

//class Home extends StatefulWidget {
//
//  @override
//  _HomeState createState() => _HomeState();
//}
//class _HomeState extends State<Home> {
//  @override
//  void initState() {
//    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context, listen: false);
//   // getFoods(foodNotifier);
//    //getFoods(foodNotifier);
//    super.initState();
//  }
//
////UserCredential
//  ParseUser _parseUser;
////Check User credential -- initState();
////  getFoods(FoodNotifier foodNotifier) async {
////
////    QueryBuilder<ParseObject> queryPost =
////    QueryBuilder<ParseObject>(ParseObject('mapping'))
////      ..whereEqualTo('uid', 'djjdfasldkfjhas');
////    var apiResponse = await queryPost.query();
////    print(apiResponse.result[0]);
////    //var apiResponse = await queryPost.query();
////    print( apiResponse.result[2]);
////    List<CourseSection> _foodList = [];
////    apiResponse.result.forEach((document) {
//////      print('documnet values 1');
//////      print(document['longitude']);
//////      CourseSection food;
//////      food.latitude=document['latitude'];
//////      food.longitude=document['longitude'];
////      CourseSection food = CourseSection.fromJson(document);
////      _foodList.add(food);
////    });
////    //var foodNotifier;
////    foodNotifier.foodList = _foodList;
////    print(_foodList.length);
////
////  }
//
////Login
//  Future<ParseUser> Login(username, pass, email) async {
//    var user = ParseUser(username, pass, email);
//    var response = await user.login();
//    if (response.success) {
//      setState(() {
//        _parseUser = user; //Keep the user
//      });
//      print(user.objectId);
//    } else {
//      print(response.error.message);
//    }
//  }
//
////Sign UP
//  Future<ParseUser> SignUP(username, pass, email) async {
//    var user = ParseUser(username, pass,
//        email); //You can add Collumns to user object adding "..set(key,value)"
//    var result = await user.create();
//    if (result.success) {
//      setState(() {
//        _parseUser = user; //Keep the user
//      });
//      print(user.objectId);
//    } else {
//      print(result.error.message);
//    }
//  }
////Controllers
//  final usernameController = TextEditingController();
//  final emailController = TextEditingController();
//  final passController = TextEditingController();
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//          title: Text('Demo App')
//      ),
//      body: Column(
//        children: <Widget>[
//          TextField(
//            controller: usernameController,
//            decoration: InputDecoration(
//                hintText: 'Username'
//            ),
//          ),
//          TextField(
//            controller: emailController,
//            decoration: InputDecoration(
//                hintText: 'E-mail'
//            ),
//          ),
//          TextField(
//            controller: passController,
//            decoration: InputDecoration(
//                hintText: 'Pass'
//            ),
//          ),
//          FlatButton(
//            child: Text('Login'),
//            onPressed: () {
//              Login(usernameController.text, passController.text,
//                  emailController.text);
//            },
//          ),
//          FlatButton(
//            onPressed: () {
//              SignUP(usernameController.text, passController.text,
//                  emailController.text);
//            },
//            child: Text('Sign Up'),
//          ),
//          FlatButton(
//            child: Text('Logout'),
//            onPressed: ()async{
//              var user = _parseUser;
//              var response = await user.logout();
//              if(response.success){
//                _parseUser = null;
//                print("LOGOFF SUCCESS");
//                usernameController.clear();
//                emailController.clear();
//                passController.clear();
//              } else{
//                print(response.error.message);
//              }
//            },
//          )
//        ],
//      ),
//    );
//  }
//
//
//
//}
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
////
////import 'package:flutter/material.dart';
////import 'package:lora_gpstracking2/models/courseSection.dart';
////
////import 'package:lora_gpstracking2/models/record..dart';
////import 'package:lora_gpstracking2/models/user.dart';
////import 'package:lora_gpstracking2/notifier/authnotifier.dart';
////import 'package:lora_gpstracking2/notifier/mapnotifier.dart';
////import 'package:parse_server_sdk/parse_server_sdk.dart';
//
//
////getFoods(FoodNotifier foodNotifier) async {
////  QueryBuilder<ParseObject> queryPost =
////  QueryBuilder<ParseObject>(ParseObject('mapping'))
////    ..whereEqualTo('uid', 'djjdfasldkfjhas');
////  //queryPost.
////
////  List<CourseSection> _foodList = [];
////
////  queryPost.documents.forEach((document) {
////    CourseSection food = CourseSection.fromJson(document.data);
////    _foodList.add(food);
////  });
////
////  foodNotifier.foodList = _foodList;
////}
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
////
////
////
////getFoods(FoodNotifier foodNotifier) async {
//////  var apiResponse2 = await ParseObject('mapping').getObject('bZH16mFjOk');
////  List<CourseSection> _foodList = [];
//////  _foodList.add(apiResponse2.result['latitude']);
//////  _foodList.add(apiResponse2.result['longitude']);
////// // print(_foodList);
////
////
////  QueryBuilder<ParseObject> queryPost =
////  QueryBuilder<ParseObject>(ParseObject('mapping'))
////    ..whereEqualTo('uid', 'djjdfasldkfjhas');
////
////  print('current query is here');
////  //var val= queryPost.whereEqualTo('uid', 'djjdfasldkfjhas');
////  var apiResponse = await queryPost.query();
////  print( apiResponse.result[2]);
////  //var i=0;
////  apiResponse.result.forEach((document) {
////
////    //print(document);
////    CourseSection food = CourseSection.fromJson(document);
////    // i++;
////    print(food.latitude);
////    //print(food.longitude+" "+food.latitude+"\n");
////    _foodList.add(food);
////  });
////  foodNotifier.foodList = _foodList;
////  print(_foodList[0]);
////  //print((val));
////  //queryPost.
////
////  final LiveQuery liveQuery = LiveQuery();
////  Subscription subscription = await liveQuery.client.subscribe(queryPost);
////  subscription.on(LiveQueryEvent.update, (value) async {
//////    QueryBuilder<ParseObject> queryPost2 =
//////    QueryBuilder<ParseObject>(ParseObject('mapping'))
//////      ..whereEqualTo('uid', 'djjdfasldkfjhas');
//////    List<CourseSection> _foodList = [];
//////    var apiResponse2 = await queryPost2.query();
//////    print( apiResponse2.result[2]);
////    print('live values are here');
////    print((value as ParseObject));
////    //var i=2;
////    //print(foodNotifier.currentFood.index);
////    CourseSection food1 = CourseSection.fromJson(value as ParseObject);
////    print(food1.index);
////    print(foodNotifier.foodList.where((food) => food.index.contains(food1.index)).toList());
////    //print(foodNotifier.foodList.firstWhere((i) => foodNotifier.foodList[i].index ));
////    var re=foodNotifier.foodList.where((food) => food.index.contains(food1.index));
////    //foodNotifier.foodList[food1.index]=food1;
////    print(re);
////    //foodNotifier.foodList.indexOf(element)
////
//////  CourseSection food = CourseSection.fromJson(value as ParseObject);
//////  foodNotifier.currentFood=food;
//////
//////  print(food.latitude);
////
////
//////    value.result.forEach((document) {
//////      //print(document);
//////      CourseSection food = CourseSection.fromJson(document);
//////      print(food.latitude);
//////      //print(food.longitude+" "+food.latitude+"\n");
//////      _foodList.add(food);
//////    });
//////    foodNotifier.foodList.clear();
//////    foodNotifier.foodList = _foodList;
//////    print(_foodList[0]);
//////
////
////
//////    var dietPlan = ParseObject('history')
//////      ..objectId = 'NG997zQS7e'
//////      ..add('location', [foodNotifier.foodList[0],foodNotifier.foodList[1]]);
//////    await dietPlan.save();
//////    _foodList[0]=(value as ParseObject).get('latitude');
//////    _foodList[1]=(value as ParseObject).get('longitude');
//////    foodNotifier.foodList = _foodList;
////  });
////
////}
////







class TstTing extends StatefulWidget {
  @override
  _TstTingState createState() => _TstTingState();
}

class _TstTingState extends State<TstTing> {
  Subscription subscription;
  Stream myStream;

  @override
  void initState() {
    // TODO: implement initState
     myStream=getini().stream;
    super.initState();
  }
  getini()  async{
    final LiveQuery liveQuery = LiveQuery();
    QueryBuilder<ParseObject> queryPost =
    QueryBuilder<ParseObject>(ParseObject('mapping'))
      ..whereEqualTo('uid', 'djjdfasldkfjhas');
     subscription = await liveQuery.client.subscribe(queryPost);
     return subscription;
    // myStream.subscription;
  }
  @override
  Widget _buildsome(BuildContext context, AsyncSnapshot<QuerySnapshot> values) {
      //var val=values.data.documents[0]['boardingInfo'];
      bool visible1=true;
//    if(!has=null)
//      {
//        visible1=true;
//      }
      // var valuyt=data1.data[0];
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,

        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top:70.0),
                  child: Column(
                    children: [
                      Row(
                        children: <Widget>[
                          Image.asset('assets/tickicon.png',height: 100,width: 100,),

                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Verified",
                            style: TextStyle(
                              fontSize: 28.0,
                              color: Hexcolor('#152971'),
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){

                            },
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
                              child: Container(
                                  width: MediaQuery.of(context).size.width*0.85,
                                  height: MediaQuery.of(context).size.height*0.06,
                                  decoration: BoxDecoration(
                                    color: Hexcolor('#E5E5E5'),
                                    borderRadius: BorderRadius.circular(15.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.25),
                                        blurRadius: 4,
                                        spreadRadius: 3,
                                        offset: Offset(-5,5),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[

                                        Row(

                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[ Text("Ms. Sujeet Yadav you has been Verified",
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                color: Hexcolor('#152971'),
                                              ),),
                                            ]
                                        ),


                                      ]
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Police Verification",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),),

                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Hexcolor('#736666'),
                              width: 3.0,
                            ),
                          ),
                        ),
                        height: 5,
                        width: 200,
                      ),
                      Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){

                            },
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 50, 20, 0),
                              child: Container(
                                  width: MediaQuery.of(context).size.width*0.8,
                                  height: MediaQuery.of(context).size.height*0.3,
                                  decoration: BoxDecoration(
                                    color: Hexcolor('#E5E5E5'),
                                    borderRadius: BorderRadius.circular(15.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.25),
                                        blurRadius: 4,
                                        spreadRadius: 3,
                                        offset: Offset(-5,5),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[

                                        Row(

                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Column(
                                                children: <Widget>[
                                                  Text("Police ID",
                                                    style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight: FontWeight.bold,
                                                      color: Hexcolor('#736666'),
                                                    ),),
                                                  SizedBox(width: 8,),
                                                ],
                                              ),
                                              SizedBox(width: 20,),
                                              Column(
                                                children: <Widget>[
                                                  Text("183345970",
                                                    style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight: FontWeight.bold,
                                                      color: Hexcolor('#152971'),
                                                    ),),
                                                ],
                                              ),
                                            ]
                                        ),
                                        Row(

                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Column(
                                                children: <Widget>[
                                                  Text("Police Name ",
                                                    style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight: FontWeight.bold,
                                                      color: Hexcolor('#736666'),
                                                    ),),
                                                ],
                                              ),
                                              SizedBox(width: 20,),
                                              Column(
                                                children: <Widget>[
                                                  Text("Mr. Rakesh Mishra",
                                                    style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight: FontWeight.bold,
                                                      color: Hexcolor('#152971'),
                                                    ),),
                                                ],
                                              ),
                                            ]
                                        ),
                                        Row(

                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Column(
                                                children: <Widget>[
                                                  Text("Mark",
                                                    style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight: FontWeight.bold,
                                                      color: Hexcolor('#736666'),
                                                    ),),
                                                ],
                                              ),
                                              SizedBox(width: 140,)

                                            ]
                                        ),


                                      ]
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),



                    ],
                  ),
                ),
              ],

            ),
            Row(

            ),
          ],
        ),
      );
    }
    Widget _buildBody(BuildContext context) {

      return StreamBuilder(
        //picking the status code
        stream:myStream,

//      Firestore.instance.collection('airportCounter').document('delhi')
//          .collection('verificationCounter').document('counters').collection('counter1').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data.documents[0]!=null)
          {return Padding(
            padding:  EdgeInsets.only(top: (MediaQuery.of(context).size.height*0.40),left:(MediaQuery.of(context).size.width*0.40) ),
            child: Container(
              width: 120,
              height: 100,

              child: Dialog(

                child: new CircularProgressIndicator(),
              ),
            ),
          );}
          else{
            // var new32=snapshot.data.documents[0]['boardingInfo'];
            return
              // Text('$new32');
              _buildsome(context, snapshot);
          }

        },

      );
    }

    Widget build(BuildContext context) {
      FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context, listen: false);
      print(myStream);
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(title: Text('CounterVerification')),
          body: _buildBody(context)

      );
  }
}
