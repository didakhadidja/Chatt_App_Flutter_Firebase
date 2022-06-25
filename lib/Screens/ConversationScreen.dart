import 'package:chat_app/Widgets/Widget.dart';
import 'package:chat_app/helper/Constants.dart';
import 'package:chat_app/services/Database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConversationScreen extends StatefulWidget {
  final String chatRoomId;
  ConversationScreen({this.chatRoomId});
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
   DatabaseMethods databaseMethods= new DatabaseMethods();
  TextEditingController messageTextEditingController= new TextEditingController();
   Stream chatMessageStream;

  Widget ChatWidgetList(){
    return StreamBuilder(
      stream: chatMessageStream,
      builder: (context, snapshot){
        return snapshot.hasData ? ListView.builder(
          padding: EdgeInsets.only(bottom: 75),
          itemCount: snapshot.data.documents.length,
            reverse: true,
            itemBuilder: (context,index){
            return MessageTile(snapshot.data.documents[index].data["message"],
                snapshot.data.documents[index].data["sendby"]==Constants.myName
            );
            }): Container();
      },
    );

  }

  SendMessage() {
   if(messageTextEditingController.text.isNotEmpty){
     Map<String,dynamic> messageMap={
       "message": messageTextEditingController.text,
       "sendby": Constants.myName,
       "time": DateTime.now().millisecondsSinceEpoch,
     };
     databaseMethods.addConversationMessages(widget.chatRoomId, messageMap);
     messageTextEditingController.text="";
   }
  }

  @override
  void initState() {
    databaseMethods.getConversationMessages(widget.chatRoomId).then((val){
     setState(() {
       chatMessageStream=val;
     });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMain(context),

      body: Container(
        child: Stack(
          children: <Widget>[
            ChatWidgetList(),
            Container(
              //color: Colors.white,

              alignment: Alignment.bottomCenter,
              //height: 80,
              //padding: EdgeInsets.only(top: 20),
              child: Container(
                //color: Colors.grey[800],
                height: 75,
                decoration: BoxDecoration(
                  //borderRadius: BorderRadius.circular(50),
                  //border: Border.all(color: Colors.white),
                  //border: Border.all(color: Color(0xff5451D7),width: 2),
                  color: Colors.white,
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: messageTextEditingController,
                        style: TextStyle(color: Colors.black),

                        decoration: InputDecoration(
                          fillColor: Color(0xffD8D9DD),
                          filled: true,
                          hintText: "Message...",
                          hintStyle: TextStyle(color: Colors.grey[900]),

                          //icon: Icon(Icons.search,size: 30, color: Colors.white54),

                          /* focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                )
                            ),*/
                          //border: InputBorder.none,
                          /*focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 2.0),
                          ),*/
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffD8D9DD), width: 2.0),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          /*border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: Color(0xff5451D7), width: 5.0),

                          ),*/
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
                        //initiateSearch();
                         SendMessage();
                      },
                      child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            //color: Colors.red,
                          ),
                          //padding: EdgeInsets.only(top: 0),
                          child: Icon(Icons.send,color: Color(0xff5451D7),size: 30,)
                      ),
                    )
                    ,
                  ],
                ),
              ),
            ),

          ],
        ),

      ),
    );
  }
}


class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByMe;
  MessageTile(this.message, this.isSendByMe);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: isSendByMe ? 20:0, left: isSendByMe ? 0:20),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isSendByMe ? [
              //const Color(0xff007EF4),
              //const Color(0xff2A75BC)
              const Color(0xff5451D7),
              //const Color(0xffE7325B)
              const Color(0xff5451D7),
            ]: [
              const Color(0xffD8D9DD),
              const Color(0xffD8D9DD),

            ],

          ),
          borderRadius: isSendByMe ?
              BorderRadius.only(topLeft: Radius.circular(23), topRight: Radius.circular(23), bottomLeft: Radius.circular(23) ):
          BorderRadius.only(topLeft: Radius.circular(23), topRight: Radius.circular(23), bottomRight: Radius.circular(23) )
        ),
        child: Text(message,style: isSendByMe ? TextStyle(color: Colors.white, fontSize: 17):TextStyle(color: Colors.black, fontSize: 17)),
      ),
    );
  }
}
