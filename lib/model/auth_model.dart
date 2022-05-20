import 'package:cashcounter/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  // For Authentication related functions you need an instance of FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  //  This getter will be returning a Stream of User object.
  //  It will be used to check if the user is logged in or not.
  Stream<User?> get authStateChange => _auth.authStateChanges();

  // Now This Class Contains 3 Functions currently
  // 1. signInWithGoogle
  // 2. signOut
  // 3. signInwithEmailAndPassword

  //  All these functions are async because this involves a future.
  //  if async keyword is not used, it will throw an error.
  //  to know more about futures, check out the documentation.
  //  https://dart.dev/codelabs/async-await
  //  Read this to know more about futures.
  //  Trust me it will really clear all your concepts about futures

  //  SigIn the user using Email and Password
  Future<void> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Error Occured'),
          content: Text(e.toString()),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text("OK"))
          ],
        ),
      );
    }
  }

  //  Future<void> googleSignIn(BuildContext context) async {
  //   try {
  //     GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
  //     if (googleSignInAccount != null) {
  //       GoogleSignInAuthentication googleSignInAuthentication =
  //           await googleSignInAccount.authentication;

  //       AuthCredential credential = GoogleAuthProvider.credential(
  //         idToken: googleSignInAuthentication.idToken,
  //         accessToken: googleSignInAuthentication.accessToken,
  //       );

  //       try {
  //         UserCredential userCredential =
  //             await auth.signInWithCredential(credential);

  //         Navigator.pushAndRemoveUntil(
  //             context,
  //             MaterialPageRoute(builder: (builder) => const Home()),
  //             (route) => false);
  //       } catch (e) {
  //         final snackbar = SnackBar(content: Text(e.toString()));
  //         ScaffoldMessenger.of(context).showSnackBar(snackbar);
  //       }
  //     } else {
  //       final snackbar = SnackBar(content: Text("Not Able to sign In "));
  //       ScaffoldMessenger.of(context).showSnackBar(snackbar);
  //     }
  //   } catch (e) {
  //     final snackbar = SnackBar(content: Text(e.toString()));
  //     ScaffoldMessenger.of(context).showSnackBar(snackbar);
  //   }
  // }

  // SignUp the user using Email and Password
  Future<void> signUpWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      final snackbar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      // await showDialog(
      //     context: context,
      //     builder: (ctx) => AlertDialog(
      //             title: Text('Error Occured'),
      //             content: Text(e.toString()),
      //             actions: [
      //               TextButton(
      //                   onPressed: () {
      //                     Navigator.of(ctx).pop();
      //                   },
      //                   child: Text("OK"))
      //             ]));
    } catch (e) {
      if (e == 'email-already-in-use') {
        print('Email already in use.');
      } else {
        print('Error: $e');
      }
    }
  }

  //  SignIn the user Google
  Future<void> signInWithGoogle(BuildContext context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (builder) => const Home()),
        (route) => false);

    try {
      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      final snackbar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      // await showDialog(
      //   context: context,
      //   builder: (ctx) => AlertDialog(
      //     title: Text('Error Occured'),
      //     content: Text(e.toString()),
      //     actions: [
      //       TextButton(
      //           onPressed: () {
      //             Navigator.of(ctx).pop();
      //           },
      //           child: Text("OK"))
      //     ],
      //   ),
      // );
    }
  }

  //  SignOut the current user
  Future<void> signOut() async {
    await _auth.signOut();
  }

  void showSnackBar(BuildContext context, String text) {
    final snackbar = SnackBar(content: Text(text.toString()));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
