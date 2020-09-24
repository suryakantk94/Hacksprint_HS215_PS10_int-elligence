import 'package:flutter/material.dart';
import 'package:pockett/screens/login.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, widget) => ResponsiveWrapper.builder(
            BouncingScrollWrapper.builder(context, widget),
            maxWidth: 1200,
            minWidth: 480,
            defaultScale: true,
            breakpoints: [
              ResponsiveBreakpoint.resize(350, name: MOBILE),
              ResponsiveBreakpoint.autoScale(800, name: TABLET),
              ResponsiveBreakpoint.resize(1000, name: DESKTOP),
            ],
            background: Container(color: Color(0xFFF5F5F5))),
        initialRoute: "/",
        title: 'Pockett',
        home: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Colors.blue[900],
            Colors.blue[800],
            Colors.blue[400]
          ])),
          child: AnimatedSplashScreen(
            duration: 3000,
            splash: Flex(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              direction: Axis.vertical,
              children: [
                Image.asset(
                  'assets/images/icon.png',
                  width: 150,
                  height: 150,
                ),
                Text("POCKETT",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.bebasNeue(
                        fontSize: 52.2, color: Colors.black)),
                Text("GET YOUR EXPENSE IN CONTROL",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.bebasNeue(
                        fontSize: 19.2, color: Colors.yellow)),
              ],
            ),
            splashIconSize: 500,
            nextScreen: Login(),
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: Color.fromRGBO(20, 17, 237, .4),
          ),
        ));
  }
}
