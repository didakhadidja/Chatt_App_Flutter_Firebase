//import 'dart:html';

import 'package:chat_app/Screens/ChatRoomScreen.dart';
import 'package:chat_app/Widgets/Widget.dart';
import 'package:chat_app/helper/HelperFunction.dart';
import 'package:chat_app/services/Database.dart';
import 'package:chat_app/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  final Function toogle;
  SignupScreen(this.toogle);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

      AuthMethods authMethods =new AuthMethods();
      DatabaseMethods databaseMethods = new DatabaseMethods();
      HelperFuction helperFunction= new HelperFuction();

      bool isLoading =false;
      final formKey = GlobalKey<FormState>();
      TextEditingController usernameTextEdetingController = new TextEditingController();
      TextEditingController emailTextEdetingController = new TextEditingController();
      TextEditingController passwordTextEdetingController = new TextEditingController();

      SignMeUp(){
        if(formKey.currentState.validate()){

          Map<String , String> userinfoMap={
            "name": usernameTextEdetingController.text,
            "email": emailTextEdetingController.text,
          };

          HelperFuction.saveUserEmailSharedPreferneces(emailTextEdetingController.text);
          HelperFuction.saveUsernameSharedPreferneces(usernameTextEdetingController.text);


           setState(() {
             isLoading= true;
           });
           authMethods.signUpWithEmailAndPassword
             (emailTextEdetingController.text, passwordTextEdetingController.text).then((val) =>
               print('${val.uid}')
           );

           databaseMethods.uploadUserInfo(userinfoMap);
           HelperFuction.saveUserLoggedInSharedPreferneces(true);
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ChatRoom()
           ));
        }
      }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: Drawer(),
     // appBar: AppBarMain(context),

      body: isLoading ? Container(
        child: Center(child: CircularProgressIndicator()),
      ) : SingleChildScrollView(
        child: Container(

          //margin: EdgeInsets.only(top: 100),
          //padding: EdgeInsets.symmetric(horizontal: 24),
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(top: 30, right: 30, left: 30),
          decoration: BoxDecoration(
            color: Color(0xff5451D7),
           // color: Colors.grey[900],
          ),
          child: Column(
            //mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 20,),
              Image.asset("assets/images/logo hedra.png",width: 200,),

             Form(
               key: formKey,
               child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: (val){
                      return val.isEmpty || val.length < 8 ? "enter your username" : null;
                    },
                    controller: usernameTextEdetingController,

                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(

                        hintText: "username",
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
                   SizedBox(height: 12,),

                  TextFormField(
                    controller: emailTextEdetingController,
                    style: TextStyle(color: Colors.white),
                    validator: (val){
                      return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ?
                      null : "Enter correct email";
                    },


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

                  SizedBox(height: 12,),

                  TextFormField(
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                    controller: passwordTextEdetingController,
                    validator:  (val){
                      return val.length < 6 ? "Enter Password 6+ characters" : null;
                    },


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




              SizedBox(height: 25,),
              /*Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text("Forgot Password?",
                  style: TextStyle(fontSize: 15 , color: Colors.white),
                ),
              ),*/
              SizedBox(height: 40,),
              GestureDetector(
                onTap: (){
                  SignMeUp();
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 17),
                  // height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,

                  ),
                  child: Text("Sign Up" , style: TextStyle(fontSize: 22 , color: Color(0xff5451D7), fontWeight: FontWeight.bold),),
                ),
              ),

              SizedBox(height: 16,),



             /* Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 18),
                // height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  //color: Colors.white,
                  border: Border.all(color: Color(0xffE7325B),width: 2),

                ),
                child: Text("Sign Up with Google" , style: TextStyle(fontSize: 18 , color: Colors.white),),
              ),*/

             // SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Already have account?",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: (){
                      widget.toogle();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text("Sign In now",
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
