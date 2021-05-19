import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sell_si/screen/Login.dart';
import 'package:sell_si/screen/register.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Resiter/Login")
      ),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
        children:<Widget>[
          SizedBox(
            width:double.infinity,
            height: 50,
            child:ElevatedButton.icon(
            icon:Icon(Icons.add),
            label: Text("register",style: TextStyle(fontSize: 20),
            ),
            onPressed:(){
              Navigator.push(context,MaterialPageRoute(builder: (context){
                return Register();
               })
               );

            },

            ),     
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
          ),
          SizedBox(
            width:double.infinity,
            height: 50,
            child:ElevatedButton.icon(
            icon:Icon(Icons.login),
            label: Text("sign in ",style: TextStyle(fontSize: 20),),
            onPressed:(){
              Navigator.push(context,MaterialPageRoute(builder: (context){
                return LoginPage();
               })
               );

            },
           ),
           
          ),
        ]
      ),
      ),
    );
  }
}