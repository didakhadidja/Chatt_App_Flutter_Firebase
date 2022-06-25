import 'package:chat_app/Screens/ConversationScreen.dart';
import 'package:chat_app/Screens/LoginScreen.dart';
import 'package:chat_app/Screens/Search.dart';
import 'package:chat_app/Widgets/Widget.dart';
import 'package:chat_app/helper/Authenticate.dart';
import 'package:chat_app/helper/Constants.dart';
import 'package:chat_app/helper/HelperFunction.dart';
import 'package:chat_app/services/Database.dart';
import 'package:chat_app/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();

}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods authMethods= new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  Stream chatRoomsStream;

  Widget ChatRoomList(){
    return StreamBuilder(
      stream: chatRoomsStream ,
      builder: (context,snapshot){
        return snapshot.hasData ? ListView.builder(
          itemCount: snapshot.data.documents.length ,
            itemBuilder: (context,index){
            return ChatRoomTile(snapshot.data.documents[index].data["chattroomid"]
            .toString().replaceAll("_", "").replaceAll(Constants.myName, ""),
                snapshot.data.documents[index].data["chattroomid"],

            );
            }): Container();
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    getUserInfo();
    super.initState();
  }

  getUserInfo()async{
    Constants.myName= await HelperFuction.getUsernameSharedPreferneces();
    databaseMethods.getChatRooms(Constants.myName).then((val){
      setState(() {
        chatRoomsStream=val;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: Color(0xff5451D7),
                    ),
                child: Stack(
                children: <Widget>[
                  Positioned(
                      bottom: 12.0,
                      left: 16.0,
                      child: Text("Hedra",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 35.0,
                              fontWeight: FontWeight.w500))),
                ]
            )),
            ListTile(
                title: Row(
                  children: <Widget>[
                    Icon(Icons.person,color: Color(0xff5451D7),),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text("My profile"),
                    )
                  ],
                ),
                onTap: (){}
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.settings,color: Color(0xff5451D7),),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text("Settings"),
                  )
                ],
              ),
              onTap: (){}
            ),
            ListTile(
                title: Row(
                  children: <Widget>[
                    Icon(Icons.exit_to_app,color: Color(0xff5451D7),),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text("Log Out"),
                    )
                  ],
                ),
                onTap: (){
                  authMethods.signOut();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Authenticate()));
                }
            ),

          ],
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.all(85.0),
          //child: Image.asset("assets/images/toppng.com-white-facebook-icon-transparent-download-facebook-black-and-white-logo-2179x427.png",width: 120,),
           child: Text("Hedra",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
        ),
        actions: [
          GestureDetector(
            onTap: (){
              authMethods.signOut();
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Authenticate()));

            },
            child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16 ),
              child: Icon(Icons.exit_to_app)
            ),
          )
        ],
      ),
      body: ChatRoomList(),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchScreen()));
        },
      ),



    );
  }
}

class ChatRoomTile extends StatelessWidget {
  final String username;
  final String chatRoom;
  ChatRoomTile(this.username, this.chatRoom);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context)=> ConversationScreen(chatRoomId: chatRoom,)));
      },
      child: Container(
        //color: Colors.red,
        //width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xff5451D7),
                    borderRadius: BorderRadius.circular(60),

                  ),
                  child: Text("${username.substring(0,1)}", style: TextStyle(fontSize: 25, color: Colors.white)),
                ),
                //SizedBox(width: 8,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(username, style: TextStyle(fontSize: 20, color: Colors.grey[900], fontWeight: FontWeight.bold)),
                      SizedBox(height: 5,),
                      Text(username, style: TextStyle(fontSize: 15, color: Colors.black)),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              //padding: EdgeInsets.only(right: 20),
              //margin: EdgeInsets.only(left: 40),
                child: Icon(Icons.message,color: Color(0xff5451D7),)),
          ],

        ),
      ),
    );
  }
}

