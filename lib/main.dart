import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CounterDownApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CounterDownApp extends StatefulWidget {
  const CounterDownApp({super.key});

  @override
  State<CounterDownApp> createState() => _CounterDownAppState();
}

class _CounterDownAppState extends State<CounterDownApp> {
  Timer? repeatedFunction;
  Duration duration = Duration(minutes: 25);

  startTimer() {
    repeatedFunction = Timer.periodic((Duration(seconds: 1)), (timer) {
      setState(() {
        int newSeconds = duration.inSeconds - 1;
        duration = Duration(seconds: newSeconds);
        if (duration.inSeconds == 0) {
          repeatedFunction!.cancel();
          setState(() {
            duration = Duration(minutes: 25);
            isRunning = false;
          });
        }
      });
    });
  }

  bool isRunning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Pomodro App",
            style: TextStyle(color: Colors.white, fontSize: 28),
          ),
          backgroundColor: Color.fromARGB(255, 59, 60, 60),
        ),
        backgroundColor: Color.fromARGB(255, 33, 44, 43),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            CircularPercentIndicator(
              radius: 130.0,
              progressColor: Color.fromARGB(255, 255, 85, 113),
              backgroundColor: Colors.white,
              lineWidth: 8.0,
              percent: duration.inMinutes / 25,
              animation: true,
              animateFromLastPercent: true,
              animationDuration: 1000,
              center: Text(
                "${duration.inMinutes.remainder(60).toString().padLeft(2, "0")}:${duration.inSeconds.remainder(60).toString().padLeft(2, "0")} ",
                style: TextStyle(fontSize: 60, color: Colors.white),
              ),
            ),
          ]),
          SizedBox(width: 25),
          SizedBox(height: 50),
          isRunning
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (repeatedFunction!.isActive) {
                            repeatedFunction!.cancel();
                          } else {
                            startTimer();
                          }
                        });
                      },
                      child: Text(
                        (repeatedFunction!.isActive) ? "Stop" : "Resume",
                        style: TextStyle(fontSize: 19),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9))),
                      ),
                    ),
                    SizedBox(width: 22),
                    ElevatedButton(
                      onPressed: () {
                        repeatedFunction!.cancel();
                        setState(() {
                          duration = Duration(minutes: 25);
                          isRunning = false;
                        });
                        setState(() {});
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(fontSize: 19),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9))),
                      ),
                    ),
                  ],
                )
              : ElevatedButton(
                  onPressed: () {
                    startTimer();
                    setState(() {
                      isRunning = true;
                    });
                  },
                  child: Text(
                    "Start Studying",
                    style: TextStyle(fontSize: 19),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9))),
                  ),
                )
        ]));
  }
}
