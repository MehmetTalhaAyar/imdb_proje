import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:imdb_proje/Classes/commentClass.dart';

class FirebaseAndFire {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static loginWithEmailAndPassword(
      String userEmail, String userPassword) async {
    try {
      await auth.signInWithEmailAndPassword(
          email: userEmail, password: userPassword);
    } catch (e) {}
  }

  static createUserEmailAndPassword(userEmail, userPassword) async {
    try {
      var _userCredental = await auth.createUserWithEmailAndPassword(
          email: userEmail, password: userPassword);

      var _myUser = _userCredental.user;
      _myUser!.sendEmailVerification();
    } catch (e) {}
  }

  static signOutUser() async {
    await auth.signOut();
  }

  //cloud fire base fonksiyonlari

  static writeUser(String email, String password, String username) async {
    await firestore.doc("users/" + email).set({
      "email": email,
      "password": password,
      "username": username,
      "movienamelist": [],
      "moviewatchlist": [],
      "movielistCounter": 0,
      "watchlistCounter": 0
    }, SetOptions(merge: true));
  }

  static addCommentToDatabase(String movieName, Comment comment) async {
    var docRef = await firestore.collection("comments").doc().id;
    await firestore.doc("comments/" + docRef).set({
      "username": comment.username,
      "comment": comment.comment,
      "likeCount": 0,
      "movieName": movieName,
      "userWhoLikedTheComment": comment.userWhoLikedTheComment,
      "date": FieldValue.serverTimestamp()
    });
  }

  // //veri okuyamıyorum
  // //geri dondururken future classında donduruyor nasıl ceviririm bulamadım.

  // static readUser(String email) async {
  //   var _userDoc = await firestore.doc("users/" + email).get();

  //   return _userDoc;
  // }

  //movie okuma da olmaz diye dusundum
  // static readMovie(String movieName) async {
  //   var _movieDoc = await firestore.doc("movies/" + movieName).get();

  //   return _movieDoc.data();
  // }

  static readMovieCollection() async {
    var _movieCollection = await firestore.collection("movies").limit(10).get();
    // int sayac = 1;
    for (var x in _movieCollection.docs) {
      // print(sayac++);
      print(x.data());
    }
  }

  static addToWatchList(String email, List watchList, int arttir) async {
    await firestore.doc("users/" + email).set({
      "moviewatchlist": watchList,
      "watchlistCounter": FieldValue.increment(arttir)
    }, SetOptions(merge: true));
  }

  static addToYourList(String email, List yourList, int arttir) async {
    await firestore.doc("users/" + email).set({
      "movienamelist": yourList,
      "movielistCounter": FieldValue.increment(arttir)
    }, SetOptions(merge: true));
  }

  //write comment metodu
  //read comment metodu
  //bir sey daha var aklıma gelmedi yeni fonksiyon dusun
}
