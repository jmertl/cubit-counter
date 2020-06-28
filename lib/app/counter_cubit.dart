import 'package:cubit/cubit.dart';

abstract class CounterState {
  final int counter;

  CounterState(this.counter);
}

class CounterInitial extends CounterState {
  CounterInitial(int counter) : super(counter);
}

class CounterUpdated extends CounterState {
  CounterUpdated(int counter) : super(counter);
}

// TODO connect with  firebase
class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterInitial(0));

  void increment() => emit(CounterUpdated(state.counter + 1));
  void decrement() => emit(CounterUpdated(state.counter - 1));
}
