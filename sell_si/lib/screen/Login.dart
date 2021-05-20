import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sell_si/main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Error"),
              ),
              body: Center(child: Text("${snapshot.error}")),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(title: Text("Login")),
              body: Container(
                  padding: EdgeInsets.all(30),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email",
                          style: TextStyle(fontSize: 20),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: email,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'PLEASE ENTER YOUR EMAIL',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                          // child: Text("Name"),
                        ),
                        Text(
                          "Password",
                          style: TextStyle(fontSize: 20),
                        ),
                        TextFormField(
                          obscureText: true,
                          controller: password,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'PLEASE ENTER YOUR PASSWORD',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton.icon(
                            icon: Icon(Icons.add_box),
                            label: Text(
                              "sign in",
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () async {
                              print(email.text + password.text);
                              try {
                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: email.text,
                                        password: password.text);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content:
                                      Text("คุณ "+ email.text +" เข้าสู่ระบบแล้ว"),
                                ));

                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return MyHomePage(title: 'HOME',);
                                }));
                              } on FirebaseAuthException catch (e) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(e.message.toString()),
                                ));
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  )),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: Text("Error"),
            ),
            body: Center(child: Text("${snapshot.error}")),
          );
        });
  }
}
