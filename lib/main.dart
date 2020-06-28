import 'package:counter/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

import 'app/counter_page.dart';

void main() => runApp(CubitCounter());

class CubitCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CubitProvider(
        create: (_) => CounterCubit(),
        child: CounterPage(),
      ),
    );
  }
}
