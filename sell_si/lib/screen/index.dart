import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sell_si/screen/index/body.dart';

class IndexScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
       body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Products").snapshots(),
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

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.delete_forever),
        onPressed: () {},
      ),
    );
  }
}
