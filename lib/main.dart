import 'package:counter/api/counter_repository.dart';
import 'package:counter/api/user_repository.dart';
import 'package:counter/app/app.dart';
import 'package:counter/app/authentication/authentication_cubit.dart';
import 'package:counter/app/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

import 'app/counter_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(CubitCounter());
}

class CubitCounter extends StatelessWidget {
  final UserRepository userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return MultiCubitProvider(
      providers: [
        CubitProvider<CounterCubit>(
          create: (BuildContext context) => CounterCubit(userRepository),
        ),
        CubitProvider<AuthenticationCubit>(
          create: (BuildContext context) => AuthenticationCubit(userRepository),
        ),
      ],
      child: MaterialApp(
        home: CubitBuilder<AuthenticationCubit, AuthenticationState>(
          builder: (context, state) {
            if (state is Uninitialized) {
              context.cubit<AuthenticationCubit>().initializeAuth();
              return SplashScreen();
              return Container(
                child: Text(state.toString()),
              );
            } else if (state is Authenticated) {
              return CounterPage();
            } else {
              return CounterPage();
            }
          },
        ),
      ),
    );
  }
}
