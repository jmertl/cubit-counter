import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'counter_freeze.freezed.dart';

@freezed
abstract class Counter implements _$Counter {
  const Counter._();
  factory Counter({String name, int number}) = _Counter;

  Map<String, Object> toDocument() {
    return {
      "name": name,
      "number": number,
    };
  }

  Counter fromSnapshot(DocumentSnapshot snap) {
    return Counter(
      name: snap.data['name'],
      number: snap.data['number'],
    );
  }
}
