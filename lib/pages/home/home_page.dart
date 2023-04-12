import 'package:ecs_attendance/database/database.dart';
import 'package:ecs_attendance/main.dart';
import 'package:ecs_attendance/pages/home/bloc/home_bloc.dart';
import 'package:ecs_attendance/pages/qr_generator/qr_generator.dart';
import 'package:ecs_attendance/utils/service.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_HomePageState>()!.restartApp();
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      key: key,
      create: (context) =>
          HomeBloc(database: MongoDatabase())..add(LoadStudentsEvent()),
      child: const HomePageView(),
    );
  }
}

class HomePageView extends StatelessWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF125252),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35),
                ),
              ),
              child: Column(
                children: [
                  //Appbar
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Center(
                        child: Text(
                          "ECS Academy",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF6fddaf).withOpacity(0.9),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        widthFactor: 10,
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          tooltip: "Logout",
                          color: const Color(0xFF6fddaf),
                          onPressed: () => SharedService.logout(context),
                          icon: const Icon(
                            Icons.logout_outlined,
                          ),
                        ),
                      ),
                    ],
                  ),
                  _addTaskBar(),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 150,
            ),
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state.attendance.isEmpty) {
                  if (state.status == HomeStatus.loading) {
                    return const CupertinoActivityIndicator();
                  } else if (state.status == HomeStatus.loaded) {
                    return QRGeneratorPage();
                  }
                }

                final student = state.attendance;
                final now = DateTime.now();
                String isPresent = student.firstWhere(
                  (date) =>
                      DateFormat("yyyy-MM-dd hh:mm:ss").parse(date) ==
                      DateTime(now.year, now.month, now.day),
                  orElse: () => "A",
                );
                return Column(children: [
                  isPresent == "A"
                      ? QRGeneratorPage()
                      : Text(
                          "Attendance marked for today! :)",
                          style: GoogleFonts.satisfy(
                            textStyle: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(
                                  0xFF63d4c0), /* Get.isDarkMode ? Colors.grey[400] : */
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 50,
                  ),
                  IconButton(
                      iconSize: 40,
                      onPressed: () => HomePage.restartApp(context),
                      icon: const Icon(Icons.refresh_rounded))
                ]);
              },
            ),
          ],
        ),
      ),
    );
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            DateFormat.yMMMMd().format(DateTime.now()),
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color:
                    Color(0xFF63d4c0), /* Get.isDarkMode ? Colors.grey[400] : */
              ),
            ),
          ),
        ],
      ),
    );
  }
}
