import 'package:counter/api/user_repository.dart';
import 'package:cubit/cubit.dart';
import 'package:flutter/foundation.dart';

abstract class AuthenticationState {}

class Uninitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final String uid;

  Authenticated(this.uid);
}

class Unauthenticated extends AuthenticationState {}

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit(this.userRepo) : super(Uninitialized());

  final UserRepository userRepo;

  Future<void> initializeAuth() async {
    final isSignedIn = await userRepo.isSignedIn();
    if (isSignedIn) {
      final uid = (await userRepo.getUser).uid;
      emit(Authenticated(uid));
    } else {
      userRepo.anonLogin();
      final isSignedIn = await userRepo.isSignedIn();
      if (isSignedIn) {
        final uid = (await userRepo.getUser).uid;
        emit(Authenticated(uid));
      } else {
        emit(Unauthenticated());
      }
    }
  }
}
