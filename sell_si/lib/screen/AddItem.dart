import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdditemPage extends StatefulWidget {
  @override
  _AdditemPageState createState() => _AdditemPageState();
}

class _AdditemPageState extends State<AdditemPage> {
  final formKey = GlobalKey<FormState>();
  final auth =  FirebaseAuth.instance;
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CollectionReference product =
      FirebaseFirestore.instance.collection("Products");
  TextEditingController title = new TextEditingController();
  TextEditingController price = new TextEditingController();
  TextEditingController desciption = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("สินค้า"),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Form(
            key: formKey,
            child: Column(
              children: [
                Text(
                  "Title",
                  style: TextStyle(fontSize: 20),
                ),
                TextFormField(
                  controller: title,
                ),
                SizedBox(
                  height: 15,
                  // child: Text("Name"),
                ),
                Text(
                  "Price",
                  style: TextStyle(fontSize: 20),
                ),
                TextFormField(
                  controller: price,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Desciption",
                  style: TextStyle(fontSize: 20),
                ),
                TextFormField(
                  controller: desciption,
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.add_box),
                    label: Text(
                      "Add",
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () async {
                    
                      product.add({
                        "title": title.text,
                        "price": price.text,
                        "desciption": desciption.text,
                        "user":   auth.currentUser!.email.toString()
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "เพิ่มสินค้า " + title.text + " ใช้เรียบร้อยแล้ว"),
                      ));
                      title.clear();
                      price.clear();
                      desciption.clear();

                    },
                  ),
                )
              ],
            )),
      ),
    );
  }
}
