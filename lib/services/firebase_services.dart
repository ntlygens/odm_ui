import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late String _firebaseTimeStamp;

  String getUserID() {
    return _firebaseAuth.currentUser!.uid;
  }

  String setDayAndTime() {
    return _firebaseTimeStamp = (DateTime.now()).toString();
  }

  final CollectionReference productsRef =
      FirebaseFirestore.instance.collection("Products");

  final CollectionReference servicesRef =
      FirebaseFirestore.instance.collection("Services");

  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection("Users");

}