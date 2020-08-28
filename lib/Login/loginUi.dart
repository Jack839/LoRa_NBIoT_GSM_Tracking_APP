import 'package:flutter/material.dart';
import 'package:lora_gpstracking2/Dashboard/devicelist.dart';
import 'package:lora_gpstracking2/Dashboard/mapping.dart';
import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lora_gpstracking2/Login/testingforparse.dart';
import 'package:lora_gpstracking2/models/user.dart';
import 'package:lora_gpstracking2/services/api.dart';
import 'package:lora_gpstracking2/services/user.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'forgot_password.dart';
import 'package:http_parser/http_parser.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:lora_gpstracking2/notifier/authnotifier.dart';
import 'package:provider/provider.dart';

class Login2 extends StatefulWidget {
  @override
  _Login2State createState() => _Login2State();
}

class _Login2State extends State<Login2> {
  bool _showPassword = false;
  void _toggle() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }
  bool checkValue=false;
  // For CircularProgressIndicator.
  bool visible = false ;
  //String message;
  var users = new List<User>();
  // Getting value from TextField widget.
  final emailController = TextEditingController();
  final usernameController=TextEditingController();
  final passwordController = TextEditingController();




  //Method for Authentication
  Future _getUsers() async{
    //authNotifier.setUser(firebaseUser);
    // Showing CircularProgressIndicator.
    setState(() {
      visible = true ;
    });
    String username=usernameController.text;
    String email = emailController.text;
    String password = passwordController.text;

    //fetching data from server
    User user;

    //authNotifier.setUser(firebaseUser);
    var users = ParseUser(username, password,email);
    var response = await users.login();
    print('user');
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    User userdefault = User.fromJson(response.result);
    authNotifier.setUser(userdefault);


    print(authNotifier.user.objectId);

    //var message=users[0].authenticated;
    // If the Response Message is Matched.
    if(response.success)
    {
      //user.username=response.result.
      // print('loc');
      // Hiding the CircularProgressIndicator.
     // authNotifier.setUser(response);

      setState(() {
        visible = false;
      });
      print(MediaQuery.of(context).size);
      print(MediaQuery.of(context).size.width);
      print(MediaQuery.of(context).size.height);
      //Storing the username and password in shared prefrences
      final storage = new FlutterSecureStorage();
      await storage.write(key: "username1", value: response.statusCode.toString());
      await storage.write(key: "password", value: password);
      await storage.write(key: "objectId", value: authNotifier.user.objectId);
      //Navigate to Profile Screen & Sending Email to Next Screen.
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DeviceList(),),
      );
    }
    else{
      // If Email or Password did not Matched.

      //1. Hiding the CircularProgressIndicator.
      setState(() {
        visible = false;
      }
      );

      //2. Showing Alert Dialog with Response JSON Message.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Invalid Username or Password"),
            actions: <Widget>[
              FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () async
        {
          SystemNavigator.pop();
          return false;
          },
      child:Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        body: Column(
        children: <Widget>[

          Padding(
            padding:
            EdgeInsets.only(top: MediaQuery.of(context).size.height / 8),
           ),

          Padding(
            padding:
            EdgeInsets.only(top: MediaQuery.of(context).size.height / 11),
          ),

          Column(
            children: <Widget>[


              //holds user header and inputField-----------------------------
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.height / 20, bottom: 10),
                    child: Text(
                      "Welcome Back",
                      style: GoogleFonts.robotoCondensed(
                        textStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.height / 28,
                        ),
                      )

                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.height / 20, top:  MediaQuery.of(context).size.height / 150),
                    child: Text(
                      "Sign in to continue",
                      style: GoogleFonts.robotoCondensed(
                        textStyle:TextStyle(fontSize: MediaQuery.of(context).size.height / 45, color: Colors.black54),
                    ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left:MediaQuery.of(context).size.height / 20,top:50),
                    child: Text(
                      "Enter Username",
                      style: GoogleFonts.robotoCondensed(
                        textStyle:TextStyle(fontSize: MediaQuery.of(context).size.height / 55, color: Colors.black87,fontWeight:FontWeight.bold),
                    ),),
                  ),
                  Padding
                    (
                    padding: EdgeInsets.only(left:MediaQuery.of(context).size.height / 20,),
                    child: TextField
                      (
                      controller: usernameController,
                      autocorrect: true,
                      decoration: InputDecoration
                        (
                        border: InputBorder.none,
                        hintText: "John",
                        hintStyle:  GoogleFonts.robotoCondensed(
                          textStyle: TextStyle(color: Color(0xFFE1E1E1), fontSize: MediaQuery.of(context).size.height / 55),),
                      ),
                    ),
                  ),
                  Padding(
                        padding: EdgeInsets.only(left:MediaQuery.of(context).size.height / 20,right:MediaQuery.of(context).size.height / 20),
                        child: Divider(
                          height: 2.0,
                          color: Colors.black87,
                        ),
                      ),

                  //header and inputField ends-----------------------------


                  //holds password header and inputField-----------------------------
                  Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.height / 20, top: MediaQuery.of(context).size.height / 20),
                    child: Text(
                      "Enter Password",
                      style:  GoogleFonts.robotoCondensed(
                        textStyle:TextStyle(fontSize: MediaQuery.of(context).size.height / 55, color: Colors.black87,fontWeight:FontWeight.bold),
                    ),),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.height / 20, ),
                    child: TextField(
                      controller: passwordController,
                      obscureText: _showPassword,
                      autocorrect: true,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "*********",
                          hintStyle:  GoogleFonts.robotoCondensed(
                            textStyle:TextStyle(color: Color(0xFFE1E1E1), fontSize: MediaQuery.of(context).size.height / 55),),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            _toggle();
                          },
                          child: Padding(
                            padding:  EdgeInsets.only(right:MediaQuery.of(context).size.height / 20),
                            child: Icon(
                              _showPassword ? Icons.visibility : Icons
                                  .visibility_off, color: Colors.black54,),
                          ),
                        ),


                      ),
                    ),

                  ),
                  Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.height / 20,right:MediaQuery.of(context).size.height / 20),
                    child: Divider(
                      height: 2.0,
                      color: Colors.black87,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.height / 20, top: MediaQuery.of(context).size.height / 20),
                    child: Text(
                      "Enter Password",
                      style:  GoogleFonts.robotoCondensed(
                        textStyle:TextStyle(fontSize: MediaQuery.of(context).size.height / 55, color: Colors.black87,fontWeight:FontWeight.bold),
                      ),),
                  ),

                  Padding
                    (
                    padding: EdgeInsets.only(left:MediaQuery.of(context).size.height / 20,),
                    child: TextField
                      (
                      controller: emailController,
                      autocorrect: true,
                      decoration: InputDecoration
                        (
                        border: InputBorder.none,
                        hintText: "JohnDoe@example.com",
                        hintStyle:  GoogleFonts.robotoCondensed(
                          textStyle: TextStyle(color: Color(0xFFE1E1E1), fontSize: MediaQuery.of(context).size.height / 55),),
                      ),
                    ),
                  ),
                ],),
              //Password header and inputField ends-----------------------------


              Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.height / 20,right:MediaQuery.of(context).size.height / 20),
                child: Divider(
                  height: 2.0,
                  color: Colors.black87,
                ),
              ),
              //Sign in button
              Padding(
                padding: EdgeInsets.only(top:MediaQuery.of(context).size.height / 20),
              ),
              ButtonTheme(
                minWidth: MediaQuery.of(context).size.height / 2.5,
              height: MediaQuery.of(context).size.height / 14,
              child:RaisedButton(
                onPressed: () async {
                  _getUsers();
                },

                color: Color(0xff40b7ad),
                child: Text(
                  "Login",style:  GoogleFonts.robotoCondensed(
                  textStyle:TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.height /53,
                ),),
                ),

              ),
              ),

              Padding(
                padding: EdgeInsets.only(top:MediaQuery.of(context).size.height / 50),
              ),
             FlatButton(
                  onPressed: ()  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=>ForgetPassword(),),);
                  },
               color: Colors.white,
                  child: Text(
                    "Forgot Password?",style:  GoogleFonts.robotoCondensed(
                    textStyle:TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height / 53,
                  ),),
                  ),

                ),
              Visibility(
                  visible: visible,
                  child:
                  Container(
                      margin: EdgeInsets.only(top: 0),
                      child: CircularProgressIndicator()
                  )
              ),
            ],
          )
        ],
    ),
      ),
    );
  }
  }




