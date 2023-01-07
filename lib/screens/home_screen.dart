import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var totalSeconds = 1500;
  late Timer _timer;
  bool isRunning = false;
  var pomodoro = 0;

  void playTimer() {
    setState(() {
      isRunning = true;
      _timer = Timer.periodic(const Duration(seconds: 1), tickDown);
    });
  }

  void pause() {
    _timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void tickDown(Timer timer) {
    setState(() {
      totalSeconds -= 1;
      if (totalSeconds == 0) {
        pomodoro += 1;
        isRunning = false;
        _timer.cancel();
        totalSeconds = 1500;
      }
    });
  }

  String showRemainTime() {
    var hour = (totalSeconds ~/ 60).toString();
    var minute = (totalSeconds % 60).toString();
    String time;
    minute.length == 1 ? time = '$hour : 0$minute' : time = '$hour : $minute';
    return time;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: Container(
              alignment: const Alignment(0, 0),
              child: Text(
                showRemainTime(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 80,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: Container(
              alignment: const Alignment(0, -0.5),
              child: IconButton(
                iconSize: 100,
                padding: EdgeInsets.zero,
                onPressed: isRunning == true ? pause : playTimer,
                icon: Icon(
                  isRunning == true
                      ? Icons.pause_circle_outline_rounded
                      : Icons.play_circle_outlined,
                  color: Theme.of(context).cardColor,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Theme.of(context).cardColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Pomodoro',
                        style: TextStyle(
                          fontSize: 23,
                          color: Theme.of(context).textTheme.headline1!.color,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '$pomodoro',
                        style: TextStyle(
                          fontSize: 52,
                          color: Theme.of(context).textTheme.headline1!.color,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
