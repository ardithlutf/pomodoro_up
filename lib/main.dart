import 'package:dotted_border/dotted_border.dart';
import 'package:drift_db_viewer/drift_db_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomodoro_up/dashboardWidgets.dart';
import 'package:pomodoro_up/focusTimer.dart';
import 'package:pomodoro_up/providers/database.dart';
import 'package:pomodoro_up/providers/injector.dart';
import 'package:provider/provider.dart';

void main() async {
  try {
    await setupDatabase();
  } catch (e) {}

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'UI-Stopwatch',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'UI-Stopwatch'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with PomodoroUpWidgets {
  var isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [Provider(create: (_) => AppDb())],
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 68.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 17.0),
                  child: Text(widget.title),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 17.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://www.goodmorningimagesdownload.com/wp-content/uploads/2021/07/1080p-New-Cool-Whatsapp-Dp-Profile-Images-pictures-hd-1-300x300.jpg'),
                  ),
                )
              ],
            ),
            const SizedBox(height: 30.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
              child: Text('Choose Priorities',
                  style: PomodoroUpWidgets.titleStyle),
            ),
            const SizedBox(height: 48.0),
            Stack(
              children: [
                RotationTransition(
                  turns: const AlwaysStoppedAnimation(-10 / 360),
                  child: Center(
                    child: SizedBox(
                      width: 250,
                      height: 310,
                      child: Card(
                        color: const Color.fromRGBO(196, 165, 204, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(21.5),
                        ),
                        child: Container(),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: 250,
                    height: 310,
                    child: Card(
                      color: const Color.fromRGBO(95, 67, 156, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(21.5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: IconButton(
                                    icon: isPlaying
                                        ? const Icon(
                                            Icons.pause_circle_outline,
                                          )
                                        : const Icon(Icons.play_circle_outline),
                                    onPressed: () {
                                      setState(() {
                                        isPlaying = !isPlaying;
                                      });

                                      if (isPlaying) {
                                        Get.to(FocusTimer(
                                                isPlaying: isPlaying))!
                                            .then((value) {
                                          setState(() {
                                            isPlaying = value;
                                          });
                                        });
                                      }
                                    },
                                    iconSize: 80.0,
                                    color: Colors.white,
                                  ),
                                ),
                                Container(height: 30),
                                GestureDetector(
                                  onTap: () async {
                                    await AppDb().saveTask(TaskData(
                                        id: 4,
                                        dueDate: DateTime.now()
                                            .add(Duration(days: 2)),
                                        title: 'Research',
                                        priority: 1));
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DriftDbViewer(AppDb())));
                                  },
                                  child: const Text('Project research',
                                      style: PomodoroUpWidgets.titleCardStyle),
                                ),
                                const Text('Deadline: 27 Nov, 2022',
                                    style: PomodoroUpWidgets.subtitleCardStyle),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('Priority',
                                    style:
                                        PomodoroUpWidgets.subtitle2CardStyle),
                                CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    maxRadius: 14,
                                    child: Text('1',
                                        style: PomodoroUpWidgets
                                            .subtitle2CardStyle)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: SizedBox(
            height: 142.0,
            child: Container(
              color: const Color.fromRGBO(228, 240, 255, 0.4),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 18.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    priorWidget(true, Colors.orange, false, 1),
                    priorWidget(false, Colors.orange, false, 2),
                    priorWidget(false, const Color.fromRGBO(255, 185, 114, 1.0),
                        false, 3),
                    priorWidget(false, Colors.orange, true, 0),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Widget priorWidget(isSelected, color, isInfo, prior) {
    if (isSelected) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(30.0),
          dashPattern: [10, 10],
          color: Colors.grey,
          strokeWidth: 2,
          child: Container(
            height: 60,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
            child: CircleAvatar(
                backgroundColor: const Color.fromRGBO(228, 240, 255, 0.4),
                minRadius: 30.0,
                child: Text(prior.toString(),
                    style: const TextStyle(color: Colors.black))),
          ),
        ),
      );
    }
    return InkWell(
      borderRadius: BorderRadius.circular(32.0),
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          height: 64,
          decoration: BoxDecoration(
              color: isInfo ? Colors.black : color,
              borderRadius: BorderRadius.circular(32.0)),
          child: CircleAvatar(
            backgroundColor: isInfo ? Colors.black : color,
            minRadius: 32.0,
            child: isInfo
                ? const Icon(Icons.info_outline, color: Colors.white)
                : Text(prior.toString(),
                    style: TextStyle(
                        color: isSelected ? Colors.black : Colors.white)),
          ),
        ),
      ),
    );
  }
}
