import 'package:cashcounter/screens/authscreen/signup.dart';
import 'package:cashcounter/screens/home.dart';
import 'package:cashcounter/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseAuth auth = FirebaseAuth.instance;
  runApp(MaterialApp(
    home: StreamBuilder<User?>(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          final isSignedIn = snapshot.data != null;

          return isSignedIn ? Home() : SignUpPage();
        }),
    debugShowCheckedModeBanner: false,
  ));
}
