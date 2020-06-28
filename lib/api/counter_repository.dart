import 'dart:developer';

import 'package:counter/api/models/counter_freeze.dart';
import 'package:counter/api/user_repository.dart';

class CounterRepository {
  final UserRepository userRepository;

  CounterRepository({this.userRepository});

  initCounter() {
    Counter counter = Counter(name: 'Main counter', number: 0);
    userRepository
        .userRef()
        .then((userDoc) => userDoc.collection('counters'))
        .then((counterCollection) => counterCollection.document())
        .then((counterDoc) => counterDoc.setData(counter.toDocument()));
  }

  Future<Map<String, dynamic>> getData() {
    return userRepository
        .userRef()
        .then((userDoc) => userDoc.collection('counters'))
        .then((counterCollection) => counterCollection.document())
        .then((counterDoc) => counterDoc.get())
        .then((value) => value.data);
  }
}
