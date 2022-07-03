import 'package:flutter/material.dart';
import 'package:nerds/screens/LandingPage.dart';
import 'package:nerds/utils/constants.dart';
import 'dart:ui';
import 'package:nerds/pageArchive.dart';
import 'package:nerds/product_card.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int indexNavBar = 0;

  String titleName = "Home";
  double screenWidth = window.physicalSize.width;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          // appBar: AppBar(
          //   title: Text(titleName),
          //   backgroundColor: Colors.blueAccent,
          // ),
          body: Center(
            child: indexNavBar == 0
                ? MaterialApp(
                    debugShowCheckedModeBanner: false,
                    theme: ThemeData(
                        textTheme: TEXT_THEME_DEFAULT,
                        fontFamily: "Montserrat"),
                    home: LandingPage(),
                  )
                : indexNavBar == 1
                    ? ProductCard()
                    : PageArchive(),
          ),
          bottomNavigationBar: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: GNav(
                backgroundColor: Colors.white,
                activeColor: Colors.white,
                tabBackgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.all(16),
                gap: 20,
                onTabChange: (index) {
                  setState(() {
                    index == 0
                        ? titleName = "Home"
                        : index == 1
                            ? titleName = "Prediction"
                            : titleName = "Archives";

                    indexNavBar = index;
                  });
                },
                tabs: const [
                  GButton(
                    icon: Icons.home,
                    iconColor: Colors.blueAccent,
                    text: "Acceuil",
                  ),
                  GButton(
                    icon: Icons.calculate_rounded,
                    iconColor: Colors.blueAccent,
                    text: "Prediction",
                  ),
                  GButton(
                    icon: Icons.archive_rounded,
                    iconColor: Colors.blueAccent,
                    text: "Archives",
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
