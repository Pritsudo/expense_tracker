import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Authentication with ChangeNotifier {
  var responce = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String get userId {
    return _auth.currentUser!.uid;
  }

  Future<String> loginUser(String email, String password) async {

    responce = 'Some error occur';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        responce = 'Success';
      } else {
        responce = 'Please enter all fields';
      }
    } catch (err) {
      responce = err.toString();
    }
    return responce;
  }

  Future<String> SignupUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        User user = cred.user!;

        _firestore.collection('users').doc(user.uid).set({
          'email': user.email,
          'uid': user.uid,
        });
        responce = 'Success';
      } else {
        responce = 'Please enter all fields';
      }
    } catch (err) {
      responce = err.toString();
    }
    return responce;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
