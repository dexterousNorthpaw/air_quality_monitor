import 'package:air_quality_monitor/constants/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  DatabaseReference ref = FirebaseDatabase.instance.ref();

  final TextEditingController _controller = TextEditingController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: const NavigationDrawer(),
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Center(
            child: Text(
              'Air Quality Monitoring System',
              style: TextStyle(
                  color: Color(0xFFBC6FE3),
                  fontSize: 26,
                  fontWeight: FontWeight.w800),
            ),
          )
          ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Dashboard",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.deepPurpleAccent,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 30,
              ),
              Container(
                  decoration: const BoxDecoration(
                      color: Color(0xFFD8B2F1),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  // width: 200,
                  height: 400,
                  // color: Colors.deepPurpleAccent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Temperature',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                          Text(
                            'Carbonmonooxide \n Level',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Alcohol Level',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'LPG Level',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          Text('Air Quality Level',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                          Text('Humidity',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Expanded(
                              child: FirebaseAnimatedList(
                                query: ref,
                                itemBuilder:
                                    (context, snapshot, animation, index) {
                                  return ListTile(
                                    title: Text(
                                        snapshot
                                            .child('Temperature')
                                            .value
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue)),
                                  );
                                },
                              ),
                            ),
                            Expanded(
                              child: FirebaseAnimatedList(
                                query: ref,
                                itemBuilder:
                                    (context, snapshot, animation, index) {
                                  return ListTile(
                                    title: Text(
                                      snapshot
                                          .child('CO2')
                                          .value
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueAccent),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Expanded(
                              child: FirebaseAnimatedList(
                                query: ref,
                                itemBuilder:
                                    (context, snapshot, animation, index) {
                                  return ListTile(
                                    title: Text(
                                        snapshot
                                            .child('Alcohol')
                                            .value
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue)),
                                  );
                                },
                              ),
                            ),
                            Expanded(
                              child: FirebaseAnimatedList(
                                query: ref,
                                itemBuilder:
                                    (context, snapshot, animation, index) {
                                  return ListTile(
                                    title: Text(
                                      snapshot.child('LPG').value.toString(),
                                      style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueAccent),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Expanded(
                              child: FirebaseAnimatedList(
                                query: ref,
                                itemBuilder:
                                    (context, snapshot, animation, index) {
                                  return ListTile(
                                    title: Text(
                                        snapshot.child('Air').value.toString(),
                                        style: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueAccent)),
                                  );
                                },
                              ),
                            ),
                            Expanded(
                              child: FirebaseAnimatedList(
                                query: ref,
                                itemBuilder:
                                    (context, snapshot, animation, index) {
                                  return ListTile(
                                    title: Text(
                                        snapshot
                                            .child('Humidity')
                                            .value
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue)),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
              const SizedBox(
                height: 20,
              ),
              // const Text("Hi"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircularPercentIndicator(
                    center: const Text(
                      "CARBON \nMONO \nOXIDE",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    radius: 60.0,
                    lineWidth: 20.0,
                    percent: 0.1,
                    progressColor: const Color(0xFFBC6FE3),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  CircularPercentIndicator(
                    center: const Text(
                      "ALCOHOL \nLEVEL",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    radius: 60.0,
                    lineWidth: 20.0,
                    percent: 0.67,
                    progressColor: const Color(0xFFBC6FE3),
                  )
                ],
              ),
              const SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircularPercentIndicator(
                    center: const Text(
                      "LPG LEVEL",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    radius: 60.0,
                    lineWidth: 20.0,
                    percent: 0.39,
                    progressColor: const Color(0xFFBC6FE3),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  CircularPercentIndicator(
                    center: const Text(
                      "AIR \nQUALITY",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    radius: 60.0,
                    lineWidth: 20.0,
                    percent: 0.22,
                    progressColor: const Color(0xFFBC6FE3),
                  )
                ],
              ),
              TextButton(onPressed:(){getValue();}, child: Text("Click to Display Air result"))
            ],
          ),
        ),
      ),
    );
  }
}
