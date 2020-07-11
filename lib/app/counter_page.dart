import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:google_fonts/google_fonts.dart';

import 'counter_cubit.dart';

class CounterPage extends StatelessWidget {
  CounterPage({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Center(
        child: Container(
          height: 120,
          width: MediaQuery.of(context).size.width / 1.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35.0),
            color: const Color(0xff464646),
            boxShadow: [
              BoxShadow(
                  color: const Color(0x29000000),
                  offset: Offset(0, 14),
                  blurRadius: 9)
            ],
          ),
          child: CubitBuilder<CounterCubit, CounterState>(
            builder: (_, state) {
              if (state is CounterLoaded) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      padding: EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      onPressed: () {
                        context
                            .cubit<CounterCubit>()
                            .update(state.counter.number - 1);
                      },
                      child: Text(
                        '${state.counter.number - 1}',
                        style: GoogleFonts.montserrat(
                            fontSize: 50, color: const Color(0xffa8a8a8)),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Text(
                      '${state.counter.number}',
                      style: GoogleFonts.montserrat(
                          fontSize: 79, color: const Color(0xffffffff)),
                      textAlign: TextAlign.left,
                    ),
                    FlatButton(
                      padding: EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      onPressed: () {
                        context
                            .cubit<CounterCubit>()
                            .update(state.counter.number + 1);
                      },
                      child: Text(
                        '${state.counter.number + 1}',
                        style: GoogleFonts.montserrat(
                            fontSize: 50, color: const Color(0xffa8a8a8)),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                );
              } else if (state is CounterLoadInProgress) {
                return Center(
                  child: Text(
                    'Loading...',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              } else if (state is CounterUpdateInProgress) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      padding: EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      child: Text(
                        '${state.number - 1}',
                        style: GoogleFonts.montserrat(
                            fontSize: 50, color: const Color(0xffa8a8a8)),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Text(
                      '${state.number}',
                      style: GoogleFonts.montserrat(
                          fontSize: 79, color: const Color(0xffffffff)),
                      textAlign: TextAlign.left,
                    ),
                    FlatButton(
                      padding: EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      child: Text(
                        '${state.number + 1}',
                        style: GoogleFonts.montserrat(
                            fontSize: 50, color: const Color(0xffa8a8a8)),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                );
              } else {
                context.cubit<CounterCubit>().getCounters();
                return Center(
                    child: Text(
                  'Something wrong happend. State: $state',
                  style: TextStyle(color: Colors.white),
                ));
              }
            },
          ),
        ),
      ),
    );
  }
}
