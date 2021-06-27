
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AuthMethod{
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future signout() async{
    try{
      return await auth.signOut();
    }
    catch(e)
    {
      print(e.toString());
    }
  }

  Future<String> logIN({String email, String password}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return "Welcome";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'Email or Password is Wrong ..!!';
      } else if (e.code == 'wrong-password') {
        return 'Email or Password is Wrong ..!!';
      }
    }
  }
  Future<String> createAccount({String email, String password}) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Account created";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (e) {
      return "Error occurred";
    }
  }
  }
