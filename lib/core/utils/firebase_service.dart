import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../features/bmi/data/models/user_model.dart';

class FirebaseService {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future<void> addUser(UserModel user) {
    return users.add(user.toJson()).then((value) {
      debugPrint("User Added");
    }).catchError((error) {
      debugPrint("Failed to add user: $error");
    });
  }

  static Future signInAnonymously() async {
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          debugPrint("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          debugPrint("Unknown error.");
      }
    }
  }

  Future<List<QueryDocumentSnapshot>> getAllEntries() async {
    QuerySnapshot querySnapshot =
        await users.orderBy('created_at', descending: true).get();
    return querySnapshot.docs;
  }

  Future<void> deleteAllEntries() async {
    QuerySnapshot querySnapshot = await users.get();
    if (querySnapshot.docs.isNotEmpty) {
      for (DocumentSnapshot docSnapshot in querySnapshot.docs) {
        await docSnapshot.reference.delete();
      }
    }
  }

  Future editEntry(String weight, String height, String uId, String status,
      num result) async {
    return await users.doc(uId).update({
      'weight': weight,
      'height': height,
      'bmi_status': status,
      'bmi_result': result,
    });
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
