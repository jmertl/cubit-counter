import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:counter/api/models/counter_freeze.dart';
import 'package:counter/api/user_repository.dart';

class CounterRepository {
  final UserRepository userRepository;

  CounterRepository({this.userRepository});

  initCounter() async {
    Counter counter = Counter(name: 'Main counter', number: 0);
    userRepository
        .userRef()
        .then((userDoc) => userDoc.collection('counters'))
        .then((counterCollection) => counterCollection.document('main'))
        .then((counterDoc) => counterDoc.setData(counter.toDocument()));
  }

  Future<Map<String, dynamic>> getData() async {
    return userRepository
        .userRef()
        .then((userDoc) => userDoc.collection('counters'))
        .then((counterCollection) => counterCollection.document('main'))
        .then((counterDoc) => counterDoc.get())
        .then((value) => value.data);
  }
}
