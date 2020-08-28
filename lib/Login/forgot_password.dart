import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
//import 'package:';
class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Padding(
              padding:
              EdgeInsets.only(top: MediaQuery
                  .of(context)
                  .size
                  .height / 8),
            ),
          Padding(
              padding:
              EdgeInsets.only(top: MediaQuery
                  .of(context)
                  .size
                  .height / 11),
            ),
          Column(
              children: <Widget>[
                //holds user header and inputField-----------------------------
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left:MediaQuery.of(context).size.height / 20,bottom: 10),
                      child: Text(
                          "Need Help!",
                          style: GoogleFonts.robotoCondensed(
                            textStyle: TextStyle(
                              color: Colors.black87,
                              fontSize: MediaQuery.of(context).size.height / 20,
                              //fontWeight: FontWeight.bold,
                            ),
                          )
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.height / 20, top:  MediaQuery.of(context).size.height / 10),
                      child: Text(
                        "Visit Our Website\nwww.scratchnest.com",
                        style: GoogleFonts.robotoCondensed(
                          textStyle: TextStyle(fontSize: MediaQuery.of(context).size.height / 40,
                              color: Colors.black54,
                              ),
                        ),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left:MediaQuery.of(context).size.height / 20, top: 30),
                      child: Text(
                        "Mail Us at\nsupport@scratchnest.net",
                        style: GoogleFonts.robotoCondensed(
                          textStyle: TextStyle(fontSize: MediaQuery.of(context).size.height / 40,
                              color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                  padding: EdgeInsets.only(left:MediaQuery.of(context).size.width/3.5,top:MediaQuery.of(context).size.height/2.8, ),
                  child:   Image.asset('assets/logo_black_transparent.png',
                    width: MediaQuery.of(context).size.width/2.2,
                  ),
                ),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }
}
