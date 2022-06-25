import 'package:chat_app/Screens/LoginScreen.dart';
import 'package:chat_app/Screens/SignupScreen.dart';
import 'package:chat_app/helper/Authenticate.dart';
import 'package:chat_app/helper/HelperFunction.dart';
import 'package:flutter/material.dart';

import 'Screens/ChatRoomScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn=false;

  @override
  void initState() {
   getLogInState();
    super.initState();
  }

  getLogInState()async{
    await HelperFuction.getUserLoggedInSharedPreferneces().then((value){
      setState(() {
        userIsLoggedIn  = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     title: 'Flutter Demo',
      theme: ThemeData(
        //primaryColor: Color(0xff145C9E),
        primaryColor: Color(0xff5451D7),
        //scaffoldBackgroundColor: Color(0xff1F1F1F),
          scaffoldBackgroundColor: Color(0xffFFFFFF),
        accentColor: Color(0xff5451D7),
        fontFamily: "OverpassRegular",
        primarySwatch: Colors.blue,
      ),
      //home: Authenticate(),
      home: userIsLoggedIn != null ?  userIsLoggedIn ? ChatRoom() : Authenticate()
          : Container(
        child: Center(
          child: Authenticate(),
        ),
      ),
    );
  }
}

