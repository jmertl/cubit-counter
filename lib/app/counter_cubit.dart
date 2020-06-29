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

  Future<void> getCounters() async {
    final CounterRepository counterRepo =
        CounterRepository(userRepository: userRepo);
    emit(CounterLoadInProgress());
    try {
      final counter = await counterRepo.initCounter();
      emit(CounterLoaded(counter));
    } catch (_) {
      emit(CounterLoadFailure());
    }
  }
}
