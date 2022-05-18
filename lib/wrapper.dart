import 'package:cashcounter/screens/authscreen/signup.dart';
import 'package:cashcounter/screens/home.dart';
import 'package:cashcounter/service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AuthWrapper extends StatefulWidget {
  AuthWrapper({Key? key}) : super(key: key);

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  AuthClass authClass = AuthClass();
  bool islogin = false;
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    print(auth.currentUser);
    setState(() {
      if (auth.currentUser != null) {
        islogin = true;
      } else {
        islogin = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return (islogin) ? Home() : SignUpPage();
  }
}
