import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdditemPage extends StatefulWidget {
  @override
  _AdditemPageState createState() => _AdditemPageState();
}

class _AdditemPageState extends State<AdditemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("สินค้า"),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Form(
          child: Column(
            children: [
              Text("Title",style: TextStyle(fontSize: 20),),
              TextFormField(),
              SizedBox(
                height:15,
                // child: Text("Name"),
              ),
              Text("Price",style: TextStyle(fontSize: 20),),
              TextFormField(),
              SizedBox(
                height:15,
              ),
              Text("Desciption",style: TextStyle(fontSize: 20),),
              TextFormField(),
              SizedBox(
                height:30,
              ),
            ],
            )
          ),

      ),
    );
  }
}