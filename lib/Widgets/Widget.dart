import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget AppBarMain(BuildContext context){
  return AppBar(
    elevation: 0,
    title: Padding(
      padding: const EdgeInsets.all(85.0),
      //child: Image.asset("assets/images/toppng.com-white-facebook-icon-transparent-download-facebook-black-and-white-logo-2179x427.png",width: 120,),
    child: Text("Hedra",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
    ),




  );
}