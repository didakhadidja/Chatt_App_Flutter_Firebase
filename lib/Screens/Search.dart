import 'package:chat_app/Screens/ConversationScreen.dart';
import 'package:chat_app/Widgets/Widget.dart';
import 'package:chat_app/helper/Constants.dart';
import 'package:chat_app/services/Database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchTextEditingController= new TextEditingController();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  QuerySnapshot searchSnapshot;

  initiateSearch(){
    databaseMethods.getUserByUsername(searchTextEditingController.text).then((val){
      //print(val.toString());
      setState(() {
        searchSnapshot=val;
      });
    });
  }

  Widget searchList(){
    return searchSnapshot !=null ?  ListView.separated(
      itemCount: searchSnapshot.documents.length,
        shrinkWrap: true,
        itemBuilder: (context,index){
        return SearchTile(
          username: searchSnapshot.documents[index].data['name'],
          useremail: searchSnapshot.documents[index].data['email'],
        );
        
        },
        separatorBuilder: (context,index){
        return Divider(color: Theme.of(context).primaryColor);
    },

        ): Container(
      height: 200,
      //color: Colors.red,
      child: Text("No result found!", style: TextStyle(color: Colors.black),),
    );
  }

  createChatRoomAndStartConversation(String username){
    if(username != Constants.myName){
      String chattRoomId= getChatRoomId(username, Constants.myName);
      List<String> users= [username,Constants.myName];
      Map<String, dynamic> chatRoomMap={
        "users": users,
        "chattroomid": chattRoomId,
      };
      databaseMethods.createChattRoom(chattRoomId, chatRoomMap);
      Navigator.push(context,
          MaterialPageRoute(builder: (context)=>ConversationScreen(chatRoomId: chattRoomId)));

    }else{
        print("you cannot search");
    }
  }



  Widget SearchTile({String username, String useremail}){
    return Container(
      decoration: BoxDecoration(
        //color: Color(0xff1F1F1F),
        color: Colors.white,
        boxShadow: [
          /* BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(3, 3), // changes position of shadow
          ),*/
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(username,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),),
              SizedBox(height: 10,),
              Text(useremail,style: TextStyle(fontSize: 16,color: Colors.black),),


            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){
              createChatRoomAndStartConversation(username);

            },
            child: Container(

              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: Color(0xff5451D7),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text('Message',style: TextStyle(color: Colors.white,fontSize: 17),),
            ),
          ),

        ],
      ),
    );
  }









  @override
  void initState() {
    initiateSearch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMain(context),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(

          children: <Widget>[
            Container(
              //color: Colors.grey[800],
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                //border: Border.all(color: Colors.white),
                border: Border.all(color: Color(0xff5451D7),width: 2),
                //color: Colors.grey,
              ),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: searchTextEditingController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "search a username..",
                        hintStyle: TextStyle(color: Colors.grey[900]),

                         //icon: Icon(Icons.search,size: 30, color: Colors.white54),

                         /* focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              )
                          ),*/
                        border: InputBorder.none,
                         /* enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              )
                          )*/


                      ),



                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      initiateSearch();

                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        //color: Colors.red,
                      ),
                      //padding: EdgeInsets.only(top: 0),
                        child: Icon(Icons.search,color: Color(0xff5451D7),size: 35,)
                    ),
                  )
,
                ],
              ),
            ),
            SizedBox(height: 15,),
            searchList(),

          ],
        ),
      ),
      
    );
  }
}
/*class SearchTile extends StatelessWidget {
  final String username;
  final String useremail;
  SearchTile({this.username,this.useremail});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff1F1F1F),
        //color: Colors.red,
        boxShadow: [
         /* BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(3, 3), // changes position of shadow
          ),*/
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(username,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
              SizedBox(height: 10,),
              Text(useremail,style: TextStyle(fontSize: 16,color: Colors.white),),


            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){

            },
            child: Container(

              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: Color(0xff5451D7),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text('Message',style: TextStyle(color: Colors.white,fontSize: 17),),
            ),
          ),

        ],
      ),
    );
  }
}*/

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}

