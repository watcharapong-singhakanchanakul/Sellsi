import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
    final auth =  FirebaseAuth.instance;
      CollectionReference itemproduct =
      FirebaseFirestore.instance.collection("Products");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Product"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Products").where('user', isEqualTo :auth.currentUser!.email).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text("ยังไม่มีข้อมูล"),
            );
          }
          return ListView(
              children: snapshot.data!.docs.map((product) {
            return Container(
              child: ListTile(
                leading: CircleAvatar(
                  maxRadius: 30,
                  minRadius: 30,
                  child: FittedBox(
                    child: Text(product["price"]),
                  ),
                ),
                title: Text(product["title"]),
                subtitle: Text(product["desciption"]),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  tooltip: 'Delete  item : ' + product["title"],
                  onPressed: () {
                     product.reference.delete();
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "ลบสินค้า " + product["title"] + "เรียบร้อยแล้ว"),
                      ));
                  },
                ),
              ),
            );
          }).toList());
        },
      ),
    );
  }
}
