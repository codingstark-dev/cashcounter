import 'package:cashcounter/model/firestore_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Database {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  // Create an instance of Firebase Firestore.
  late CollectionReference
      _movies; // this holds a refernece to the Movie collection in our firestore.

  Stream get allMovies => _firestore
      .collection("users")
      .doc()
      .snapshots(); // a stream that is continuously listening for changes happening in the database
  Stream<DocumentSnapshot<Map<String, dynamic>>> get getUserDetail =>
      _firestore.collection("users").doc(_auth.currentUser?.uid).snapshots();
  // Add a Movie
  // A method that will add a new Movie m to our Movies collection and return true if its successful.
  // Future<bool> addNewMovie(Movie m) async {
  //   _movies =
  //       _firestore.collection('movies'); // referencing the movie collection .
  //   try {
  //     await _movies.add({
  //       'name': m.movieName,
  //       'poster': m.posterURL,
  //       'length': m.length
  //     }); // Adding a new document to our movies collection
  //     return true; // finally return true
  //   } catch (e) {
  //     return Future.error(e); // return error
  //   }
  // }

  // Remove a Movie
  Future<bool> removeMovie(String movieId) async {
    _movies = _firestore.collection('movies');
    try {
      await _movies
          .doc(movieId)
          .delete(); // deletes the document with id of movieId from our movies collection
      return true; // return true after successful deletion .
    } catch (e) {
      print(e);
      return Future.error(e); // return error
    }
  }

  Future<bool> createUser(Userdata m) async {
    _movies = _firestore.collection('users');
    try {
      await _movies.doc(_auth.currentUser?.uid).set({
        'name': m.name,
        "email": m.email,
        "gstminus": {"3": "3", "5": "5", "12": "12", "18": "18", "28": "28"},
        "gstplus": {"3": "3", "5": "5", "12": "12", "18": "18", "28": "28"}
      });
      print("Done");
      // update the document with id of movieId from our movies collection
      return true; // return true after successful update .
    } catch (e) {
      print(e);
      return Future.error(e); // return error
    }
  }

  Future updateGst(Map<String, Object?> gst) async {
    var _gst = _firestore.collection('users');
    try {
      await _gst.doc(_auth.currentUser?.uid).update(gst);
      Fluttertoast.showToast(msg: "Updated");
      // update the document with id of movieId from our movies collection
      return true; // return true after successful update .
    } catch (e) {
      print(e);
      return Future.error(e); // return error
    }
  }
  // Update a Movie
  // A method that will update a Movie m to our Movies collection and return true if its successful.
  // Future<bool> updateMovie(Movie m) async {
  //   _movies =
  //       _firestore.collection('movies'); // referencing the movie collection .
  //   try {
  //     await _movies.doc(m.id).update({
  //       'name': m.movieName,
  //       'poster': m.posterURL,
  //       'length': m.length
  //     }); // updating the document with id of movieId from our movies collection
  //     return true; // finally return true
  //   } catch (e) {
  //     return Future.error(e); // return error
  //   }
  // }
}
// Edit a Movie
// Future<bool> editMovie(Movie m, String movieId) async {
//   _movies = _firestore.collection('movies');
//   try {
//     await _movies
//         .doc(movieId)
//         .update(// updates the movie document having id of moviedId
//             {'name': m.movieName, 'poster': m.posterURL, 'length': m.length});
//     return true; //// return true after successful updation .
//   } catch (e) {
//     print(e);
//     return Future.error(e); //return error
//   }
// }

// Creating a simple Riverpod provider that provides an instance of our Database class so that it can be used from our UI(by calling Database class methods)
final databaseProvider = Provider((ref) => Database());
