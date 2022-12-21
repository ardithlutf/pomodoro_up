import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomodoro_up/dashboardWidgets.dart';
import 'package:pomodoro_up/providers/database.dart';
import 'package:slider_button/slider_button.dart';

class FocusTimer extends StatefulWidget {
  bool isPlaying;

  FocusTimer({Key? key, required this.isPlaying}) : super(key: key);

  @override
  State<FocusTimer> createState() => _FocusTimerState();
}

class _FocusTimerState extends State<FocusTimer> {
  final stopwatch = Stopwatch();

  Timer? timer;

  @override
  void initState() {
    stopwatch.start();

    timer = Timer.periodic(Duration.zero, (Timer t) async {
      setState(() {});
    });

    super.initState();
  }

  String intToTimeLeft(int value) {
    int h, m, s;

    h = value ~/ 3600;

    m = ((value - h * 3600)) ~/ 60;

    s = value - (h * 3600) - (m * 60);

    String hourLeft =
        h.toString().length < 2 ? "0" + h.toString() : h.toString();

    String minuteLeft =
        m.toString().length < 2 ? "0" + m.toString() : m.toString();

    String secondsLeft =
        s.toString().length < 2 ? "0" + s.toString() : s.toString();

    String result = "$hourLeft:$minuteLeft:$secondsLeft";

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(95, 67, 156, 1),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 480.0),
              child: SliderButton(
                backgroundColor: Colors.white12,
                action: () {
                  Navigator.of(context).pop(widget.isPlaying = false);
                },
                label: const Text(
                  "Finish: Project 1",
                  style: TextStyle(
                      color: Color(0xff4a4a4a),
                      fontWeight: FontWeight.w500,
                      fontSize: 17),
                ),
                icon: widget.isPlaying
                    ? const Icon(
                        Icons.close,
                      )
                    : const Icon(Icons.play_circle_outline),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Focus on process',
                    style: PomodoroUpWidgets.titleStyleWhite),
                Text('Ardith!', style: PomodoroUpWidgets.titleStyleOrange),
                SizedBox(height: 85.0),
                Text(intToTimeLeft(stopwatch.elapsed.inSeconds),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 70.0)),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: IconButton(
          color: Colors.white,
          iconSize: 35.0,
          onPressed: () {
            if (stopwatch.isRunning) {
              print(stopwatch.elapsed.inMilliseconds);
              stopwatch.stop();
              timer!.cancel();
            } else {
              stopwatch.start();
              timer = Timer.periodic(Duration.zero, (Timer t) {
                setState(() {});
              });
            }
          },
          icon: stopwatch.isRunning
              ? const Icon(Icons.pause_circle_outline)
              : const Icon(Icons.play_circle_outline)),
    );
  }
}
