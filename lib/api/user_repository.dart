import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:counter/api/counter_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final Firestore _db;

  UserRepository({FirebaseAuth firebaseAuth, Firestore db})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _db = db ?? Firestore.instance;

  // Firebase user one-time fetch
  Future<FirebaseUser> get getUser => _firebaseAuth.currentUser();

  // Firebase user a realtime stream
  Stream<FirebaseUser> get user => _firebaseAuth.onAuthStateChanged;

  Future<DocumentReference> userRef() async {
    var user = _db.collection('users').document((await getUser).uid);
    return user;
  }

  // Anonymous Firebase login
  Future<FirebaseUser> anonLogin() async {
    AuthResult result = await _firebaseAuth.signInAnonymously();
    FirebaseUser user = result.user;
    return user;
  }

  /// Updates the User's data in Firestore on each new login
  Future<void> updateUserData(FirebaseUser user) async {
    final userReference = await userRef();
    CounterRepository counterRepo = CounterRepository(userRepository: this);

    var data = await counterRepo.getData();
    if (data == null) {
      counterRepo.initCounter();
    }

    DocumentReference reportRef =
        userReference.collection('reports').document('lastActivity');
    return reportRef.setData({'lastActivity': DateTime.now()}, merge: true);
  }

  // Sign out
  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }
}
