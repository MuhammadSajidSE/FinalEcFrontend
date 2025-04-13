import 'package:agriconnect/Component/elevatedBtn.dart';
import 'package:agriconnect/Views/StartScreen/OnboardScreen2.dart';
import 'package:agriconnect/Views/StartScreen/OnboardScreen3.dart';
import 'package:agriconnect/constants/colors.dart';
import 'package:flutter/material.dart';

class OnboardScreen2 extends StatelessWidget {
  const OnboardScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: MyColors.primaryColor,
      backgroundColor: MyColors.secondaryColor,
      body: Stack(
        children: [
          /// 📌 Background Image at Bottom-Left
          Positioned(
            // left: 0,
            left: 60,
            top: 320,
            // bottom: -15,
            child: Image.asset(
              'assets/crop2.png', // Make sure the path is correct
              width: 400, // Adjust size as needed
              // height: 200,
              fit: BoxFit.cover,
            ),
          ),

          /// 📌 Bold Text on Right Side
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 50),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Taza aur\nsasti fasal\nseedha kisan\nse lo!",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontSize: 49,
                      height: 0.9,
                      // fontWeight: FontWeight.bold,
                      color: MyColors.primaryColor,
                      // color: MyColors.secondaryColor,
                    ),
                  ),

                  // const SizedBox(height: 10),
                  // Text(
                  //   "Taza aur sasti fasal seedha kisan se lo!",
                  //   textAlign: TextAlign.right,
                  //   style: TextStyle(
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.w600,
                  //     color: Colors.green[700],
                  //   ),
                  // ),
                  SizedBox(
                    height: 30,
                  ),
                  MyElevatedBtn(
                    "  Get Started  ",
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OnboardScreen3()),
                      );
                    },
                    colorInvert: false,
                  ),

                  // onPressed: () {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => const OnboardScreen2()),
                  //   );
                  // },
                  // child: Text('Yes',style: TextStyle(color: MyColors.primaryColor),),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
