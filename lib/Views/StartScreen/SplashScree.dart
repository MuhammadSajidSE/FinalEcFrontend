
import 'package:agriconnect/Views/StartScreen/OnboardScreen1.dart';
import 'package:agriconnect/constants/colors.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardScreen1()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            // left:-200,
            child: Image.asset(
              "assets/splash3.png",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.15,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'AgriConnect',
                style: TextStyle(
                  fontSize: 64,
                  fontFamily: 'Cookie',
                  fontWeight: FontWeight.w600,
                  color: MyColors.secondaryColor,
                  // shadows: [
                  //   Shadow(
                  //     blurRadius: 4,
                  //     color: Colors.black.withOpacity(0.5),
                  //     offset: Offset(2, 2),
                  //   ),
                  // ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
