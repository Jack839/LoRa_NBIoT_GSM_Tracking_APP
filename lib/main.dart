import 'package:flutter/material.dart';
import 'package:lora_gpstracking2/Dashboard/devicelist.dart';
import 'package:lora_gpstracking2/Dashboard/mapping.dart';
import 'package:lora_gpstracking2/Login/loginUi.dart';
import 'package:lora_gpstracking2/notifier/authnotifier.dart';
import 'package:lora_gpstracking2/services/user.dart';
import 'package:lora_gpstracking2/services/api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:lora_gpstracking2/notifier/mapnotifier.dart';
import 'package:provider/provider.dart';

import 'Login/testingforparse.dart';

//Checking Weather user was logged in or not last time
//Future<void> main() async {
//  var users = new List<User>();
//  WidgetsFlutterBinding.ensureInitialized();
//  //checking for previous session
//  FlutterSecureStorage storage = await FlutterSecureStorage();
//   String username1 = await storage.read(key:'username');
//   String password1=await storage.read(key:'password');
//  users = await API.getUsers(username1, password1);
//  var message=users[0].authenticated;
//  //for testing
//  print(username1);
//  print(password1);
//  print(message);
//
//  runApp(
//    MaterialApp(home: message == "true" ?  HomePage():Login2()),
//  );
//}
const String PARSE_APP_ID = 'xxxxx';
const String PARSE_APP_URL = 'http://xxx.xx.xx.xx:xxxx/parse';
const String MASTER_KEY = 'xxxxxx';
//Future<void> main() async {
//  WidgetsFlutterBinding.ensureInitialized();
//  Parse().initialize(
//    PARSE_APP_ID,
//    PARSE_APP_URL,
//    masterKey: MASTER_KEY,
//    autoSendSessionId: true,
//    debug: true,
//    coreStore: await CoreStoreSharedPrefsImp.getInstance(),
//  );
//
//
//  runApp(
//    MaterialApp(home: Login2()),
//  );
//
//}


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //  WidgetsFlutterBinding.ensureInitialized();
  Parse().initialize(
    PARSE_APP_ID,
    PARSE_APP_URL,
    masterKey: MASTER_KEY,
    autoSendSessionId: true,
    liveQueryUrl: 'ws://139.59.23.102:1337',
    debug: true,
    coreStore: await CoreStoreSharedPrefsImp.getInstance(),
  );
  FlutterSecureStorage storage = await FlutterSecureStorage();
  var username = await storage.read(key: 'username1');
  //var username=100;
  runApp(MultiProvider(

    providers: [

      ChangeNotifierProvider(
        create: (context) => FoodNotifier(),
      ),
      ChangeNotifierProvider(
        create: (context) => AuthNotifier(),
      ),
    ],
    child: MaterialApp(home:
    //Home(),

    //liveBusTrackingHome(),
      //HomePage23(),

    (username=='200')?DeviceList(): Login2()
    ),
  ),);
}

