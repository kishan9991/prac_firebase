import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class emailpass_auth extends StatefulWidget {
  const emailpass_auth({Key? key}) : super(key: key);

  @override
  State<emailpass_auth> createState() => _emailpass_authState();
}

class _emailpass_authState extends State<emailpass_auth> {

  TextEditingController temail = TextEditingController();
  TextEditingController tpassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("emailpassword"),),
      body: Column(
        children: [
          TextField(controller: temail),
          TextField(controller: tpassword),
          ElevatedButton(onPressed: () async {
            try {
              final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: temail.text,
                password: tpassword.text,
              );
              print(credential);
            } on FirebaseAuthException catch (e) {
              if (e.code == 'weak-password') {
                print('The password provided is too weak.');
              } else if (e.code == 'email-already-in-use') {
                print('The account already exists for that email.');
              }
            } catch (e) {
              print(e);
            }
          }, child: Text("Register")),
          ElevatedButton(onPressed: () async {
            try {
              final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                email: temail.text,
                password: tpassword.text,
              );
              print(credential);
            } on FirebaseAuthException catch (e) {
              if (e.code == 'user-not-found') {
                print('No user found for that email.');
              } else if (e.code == 'wrong-password') {
                print('Wrong password provided for that user.');
              }
            }
          }, child: Text("Log in"))
        ],
      ),
    );
  }
}
