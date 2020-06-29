import 'package:counter/api/counter_repository.dart';
import 'package:counter/api/user_repository.dart';
import 'package:counter/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

import 'app/counter_page.dart';

void main() => runApp(CubitCounter());

class CubitCounter extends StatelessWidget {
  final UserRepository userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CubitProvider(
        create: (_) => CounterCubit(userRepository),
        child: CounterPage(),
      ),
    );
  }
}
