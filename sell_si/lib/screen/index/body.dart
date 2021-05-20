import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // It will provie us total height  and width of our screen
    Size size = MediaQuery.of(context).size;
    // it enable scrolling on small device
    return Column(
      children: <Widget>[
        Container(
          height: size.height * 0.2,
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    left: 20.0, right: 20.0, bottom: 36 + 20.00),
                height: size.height * 0.2 - 27,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(36),
                    bottomRight: Radius.circular(36),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Sellsi',
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Image.asset("assets/images/logo.png")
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  height: 54,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: Colors.black.withOpacity(0.23),
                      ),
                    ],
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          onChanged: (value) {},
                          decoration: InputDecoration(
                            hintText: "Search",
                            hintStyle: TextStyle(
                              color: Colors.blue.withOpacity(0.5),
                            ),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      SvgPicture.asset("assets/icons/search.svg"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        StreamBuilder(
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
      ],
    );
  }
}
