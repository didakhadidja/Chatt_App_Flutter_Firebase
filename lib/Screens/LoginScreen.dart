import 'package:chat_app/Widgets/Widget.dart';
import 'package:chat_app/helper/HelperFunction.dart';
import 'package:chat_app/services/Database.dart';
import 'package:chat_app/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ChatRoomScreen.dart';

class LoginScreen extends StatefulWidget {
  final Function toogle;
  LoginScreen(this.toogle);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final formKey= GlobalKey<FormState>();
  AuthMethods authMethods= new AuthMethods();
  TextEditingController emailTextEdetingController = new TextEditingController();
  TextEditingController passwordTextEdetingController = new TextEditingController();
  DatabaseMethods databaseMethods=new DatabaseMethods();

  bool isLoading =false;
  QuerySnapshot snapshotUserInfo;
  LogIn(){
    if(formKey.currentState.validate()){

      HelperFuction.saveUserEmailSharedPreferneces(emailTextEdetingController.text);
      //HelperFuction.saveUsernameSharedPreferneces(usernameTextEdetingController.text);

      setState(() {
        isLoading=true;
      });
      databaseMethods.getUserByemail(emailTextEdetingController.text).then(
          (val){
          snapshotUserInfo=val;
          HelperFuction
              .saveUsernameSharedPreferneces(snapshotUserInfo.documents[0].data['name']);
          }
      );
      authMethods.signInWithEmailAndPassword(emailTextEdetingController.text, passwordTextEdetingController.text).then(
              (value) {
                if(value !=null){
                  HelperFuction.saveUserLoggedInSharedPreferneces(true);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ChatRoom()
                  ));

                }
              }
      );


    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // drawer: Drawer(),
      //appBar: AppBarMain(context),
      body: SingleChildScrollView(
        child: Container(
          //margin: EdgeInsets.only(top: 100),
          //padding: EdgeInsets.symmetric(horizontal: 24),
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only( top: 50, right: 30, left: 30),
          decoration: BoxDecoration(
            color: Color(0xff5451D7),
          ),
          child: Column(
            //mainAxisSize: MainAxisSize.min,
            children: <Widget>[

              SizedBox(height: 15,),
              Image.asset("assets/images/logo hedra.png",width: 200,),
              Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: emailTextEdetingController,
                      validator: (val){
                        return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ?
                        null : "Enter correct email";
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(

                          hintText: "email",
                          hintStyle: TextStyle(
                            color: Colors.white54,
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              )
                          ),

                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2,
                              )
                          )

                      ),
                    ),

                    SizedBox(height: 16,),

                    TextFormField(
                      obscureText: true,
                      controller: passwordTextEdetingController,
                      validator:  (val){
                        return val.length < 6 ? "Enter Password 6+ characters" : null;
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(

                          hintText: "Password",
                          hintStyle: TextStyle(
                            color: Colors.white54,
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              )
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2,
                              )
                          )

                      ),
                    ),
                    
                  ],
                ),
              ),

              SizedBox(height: 8,),
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text("Forgot Password?",
                style: TextStyle(fontSize: 15 , color: Colors.white),
                ),
              ),
              SizedBox(height: 50,),
              GestureDetector(
                onTap: (){
                  LogIn();
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 17),
                 // height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    //color: Color(0xff5451D7),
                    /*gradient: LinearGradient(
                      colors: [
                        //const Color(0xff007EF4),
                        //const Color(0xff2A75BC)
                        const Color(0xff5451D7),
                        const Color(0xffE7325B)
                       // const Color(0xff5451D7),
                      ]

                    ),*/

                  ),
                  child: Text("Sign In" , style: TextStyle(fontSize: 22 , color: Color(0xff5451D7),fontWeight: FontWeight.bold),),
                ),
              ),

              SizedBox(height: 16,),



              /*Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 20),
                // height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  //border: Border.all(color: Color(0xffE7325B),width: 2),
                  //color: Color(0xffE7325B),
                  color: Colors.white,

                ),
                child: Text("Sign In with Google" , style: TextStyle(fontSize: 18 , color: Colors.black),),
              ),*/

              //SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Don't havee account? ",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: (){
                      widget.toogle();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text("Register now",
                        style: TextStyle(color: Colors.white, fontSize: 16, decoration: TextDecoration.underline),
                      ),
                    ),
                  ),

                ],
              )





            ],

          ),
        ),
      ),

    );
  }
}
