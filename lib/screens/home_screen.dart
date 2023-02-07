import 'package:air_quality_monitor/providers/data_provider.dart';
import 'package:air_quality_monitor/screens/login_screen.dart';
import 'package:air_quality_monitor/services/firebase_auth.dart';
import 'package:air_quality_monitor/shared/dashboard_fields.dart';
import 'package:air_quality_monitor/shared/popup_dialog.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  final TextEditingController _controller = TextEditingController();
  NumberFormat numberFormat = NumberFormat();

  @override
  void initState() {
    Provider.of<DataProvider>(context, listen: false).getData();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: true,
        title: Text(
          'Air Quality Monitoring System',
          maxLines: 2,
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              color: Color(0xff834eed),
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showPopUpDialog(
                context: context,
                content: 'Are you sure you want to log out?',
                cancelText: 'No',
                confirmText: 'Yes',
                confirmFunction: () {
                  FirebaseAuthServices.logout();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                    (route) => false,
                  );
                },
              );
            },
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            icon: const Icon(
              Icons.logout,
              color: Color(0xff53617c),
            ),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xfff3f3f3),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 16),
                  child: Text(
                    "Dashboard",
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        fontSize: 22,
                        color: Color(0xff834eed),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xffdad1ec),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            DashboardFields(
                              fieldName: 'Temperature',
                              fieldValue: numberFormat
                                  .format(dataProvider.data.temperature),
                            ),
                            DashboardFields(
                              fieldName: 'CarbonMonooxide Level',
                              fieldValue:
                                  numberFormat.format(dataProvider.data.co),
                            ),
                            DashboardFields(
                              fieldName: 'Alcohol / Benzene Level',
                              fieldValue: numberFormat
                                  .format(dataProvider.data.alcohol),
                            ),
                            DashboardFields(
                              fieldName: 'LPG Level',
                              fieldValue:
                                  numberFormat.format(dataProvider.data.lpg),
                            ),
                            DashboardFields(
                              fieldName: 'Air Quality / Ammonia Level',
                              fieldValue: numberFormat.format(
                                  dataProvider.data.air.clamp(-500, 500)),
                            ),
                            DashboardFields(
                              fieldName: 'Humidity Level',
                              fieldValue: numberFormat
                                  .format(dataProvider.data.humidity),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                CircularPercentIndicator(
                                  center: Text(
                                    "CARBON \nMONO \nOXIDE",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.lato(
                                      textStyle: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff53617c),
                                      ),
                                    ),
                                  ),
                                  radius: 60.0,
                                  lineWidth: 20.0,
                                  percent: calculatePercentage(
                                    maxVal: 500,
                                    val: dataProvider.data.co.clamp(-499, 500),
                                  ),
                                  backgroundColor:
                                      Colors.black.withOpacity(0.15),
                                  progressColor: const Color(0xff834eed),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  height: 50,
                                  child: Text(
                                    dataProvider.data.fCO,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.lato(
                                      textStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              children: [
                                CircularPercentIndicator(
                                  center: Text(
                                    "ALCOHOL \nLEVEL",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.lato(
                                      textStyle: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff53617c),
                                      ),
                                    ),
                                  ),
                                  radius: 60.0,
                                  lineWidth: 20.0,
                                  percent: calculatePercentage(
                                    maxVal: 500,
                                    val: dataProvider.data.alcohol
                                        .clamp(-499, 500),
                                  ),
                                  backgroundColor:
                                      Colors.black.withOpacity(0.15),
                                  progressColor: const Color(0xff834eed),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  height: 50,
                                  child: Text(
                                    dataProvider.data.fAlcohol,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.lato(
                                      textStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                CircularPercentIndicator(
                                  center: Text(
                                    "AIR \nQUALITY \nLEVEL",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.lato(
                                      textStyle: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff53617c),
                                      ),
                                    ),
                                  ),
                                  radius: 60.0,
                                  lineWidth: 20.0,
                                  percent: calculatePercentage(
                                    maxVal: 500,
                                    val: dataProvider.data.air.clamp(-499, 500),
                                  ),
                                  backgroundColor:
                                      Colors.black.withOpacity(0.15),
                                  progressColor: const Color(0xff834eed),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  height: 50,
                                  child: Text(
                                    dataProvider.data.fAir,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.lato(
                                      textStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              children: [
                                CircularPercentIndicator(
                                  center: Text(
                                    "LPG \nLEVEL",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.lato(
                                      textStyle: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff53617c),
                                      ),
                                    ),
                                  ),
                                  radius: 60.0,
                                  lineWidth: 20.0,
                                  percent: calculatePercentage(
                                    maxVal: 2000,
                                    val: dataProvider.data.lpg
                                        .clamp(-1999, 2000),
                                  ),
                                  backgroundColor:
                                      Colors.black.withOpacity(0.15),
                                  progressColor: const Color(0xff834eed),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  height: 50,
                                  child: Text(
                                    dataProvider.data.fLPG,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.lato(
                                      textStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double calculatePercentage({required double maxVal, required double val}) {
    return (maxVal + val) / (2 * maxVal);
  }
}
