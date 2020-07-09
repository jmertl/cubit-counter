import 'package:counter/api/counter_repository.dart';
import 'package:counter/api/models/counter_freeze.dart';
import 'package:counter/api/user_repository.dart';
import 'package:cubit/cubit.dart';
import 'package:flutter/foundation.dart';

abstract class CounterState {}

class CounterInitial extends CounterState {}

class CounterUpdated extends CounterState {}

class CounterLoadInProgress extends CounterState {}

class CounterLoaded extends CounterState {
  CounterLoaded(this.counter);

  final Counter counter;
}

class CounterLoadFailure extends CounterState {}

// TODO connect with  firebase
class CounterCubit extends Cubit<CounterState> {
  CounterCubit(this.userRepo) : super(CounterInitial());

  final UserRepository userRepo;

  Future<void> initCounter() async {
    final CounterRepository counterRepo =
        CounterRepository(userRepository: userRepo);
    emit(CounterLoadInProgress());
    try {
      await counterRepo.initCounter();
    } catch (_) {
      emit(CounterLoadFailure());
    }
  }

  Future<void> getCounters() async {
    final CounterRepository counterRepo =
        CounterRepository(userRepository: userRepo);
    emit(CounterLoadInProgress());
    try {
      final counter = await counterRepo.getData();
      emit(CounterLoaded(
          new Counter(name: counter['name'], number: counter['number'])));
    } catch (_) {
      emit(CounterLoadFailure());
    }
  }

  Future<void> update(int number) async {
    final CounterRepository counterRepo =
        CounterRepository(userRepository: userRepo);
    emit(CounterLoadInProgress());
    try {
      final counter = await counterRepo.getData();
      Counter newCounter = new Counter(
          name: counter['name'], number: counter['number'] + number);

      counterRepo.updateData(newCounter);

      emit(CounterLoaded(newCounter));
    } catch (_) {
      emit(CounterLoadFailure());
    }
  }
}
