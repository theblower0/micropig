import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:micropig/models/brew.dart';
import 'package:micropig/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  //colletcion reference
  //FirebaseFirestore = Firestore
  //I can create new instances in 'brewCollection' using this variable, even delete and update
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  //breww list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((d) {
      return Brew(
        name: d.data()['name'] ?? '',
        strength: d.data()['strength'] ?? 0,
        sugars: d.data()['sugars'] ?? '0',
      );
    }).toList();
  }

  //userData from snapchot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data()['name'],
      sugars: snapshot.data()['sugars'],
      strength: snapshot.data()['strength'],
    );
  }

  //get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  //get user doc stream

  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
