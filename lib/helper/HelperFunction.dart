import 'package:shared_preferences/shared_preferences.dart';

class HelperFuction{


 static String sharedPreferncesUserLogInKey="ISLOGEDIN";
 static String sharedPreferncesUserNameKey="USERNAMEKEY";
 static String sharedPreferncesUserEmailKey="EMAILKEY";

 //function

static Future<void>saveUserLoggedInSharedPreferneces(bool isUserLoggedIn)async{
  SharedPreferences prefs= await SharedPreferences.getInstance();
  return await prefs.setBool(sharedPreferncesUserLogInKey, isUserLoggedIn);
}

 static Future<void>saveUsernameSharedPreferneces(String username)async{
   SharedPreferences prefs= await SharedPreferences.getInstance();
   return await prefs.setString(sharedPreferncesUserNameKey, username);
 }

 static Future<void>saveUserEmailSharedPreferneces(String email)async{
   SharedPreferences prefs= await SharedPreferences.getInstance();
   return await prefs.setString(sharedPreferncesUserEmailKey, email);
 }

 //get functions


 static Future<bool>getUserLoggedInSharedPreferneces()async{
   SharedPreferences prefs= await SharedPreferences.getInstance();
   return await prefs.getBool(sharedPreferncesUserLogInKey);
 }

 static Future<String>getUsernameSharedPreferneces()async{
   SharedPreferences prefs= await SharedPreferences.getInstance();
   return await prefs.getString(sharedPreferncesUserNameKey);
 }

 static Future<String>getUserEmailSharedPreferneces()async{
   SharedPreferences prefs= await SharedPreferences.getInstance();
   return await prefs.getString(sharedPreferncesUserEmailKey);
 }

}