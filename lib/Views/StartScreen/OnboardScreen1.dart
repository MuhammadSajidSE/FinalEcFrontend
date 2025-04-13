import 'package:agriconnect/Component/elevatedBtn.dart';
import 'package:agriconnect/Views/StartScreen/OnboardScreen2.dart';
import 'package:agriconnect/constants/colors.dart';
import 'package:flutter/material.dart';

class OnboardScreen1 extends StatelessWidget {
  const OnboardScreen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      // backgroundColor: MyColors.secondaryColor,
      body: Stack(
        children: [
          /// 📌 Background Image at Bottom-Left
          Positioned(
            // left: 0,
            right: 60,
            top: 320,
            // bottom: -15,
            child: Image.asset(
              'assets/farmer.png', // Make sure the path is correct
              width: 400, // Adjust size as needed
              // height: 200,
              fit: BoxFit.cover,
            ),
          ),

          /// 📌 Bold Text on Right Side
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 20, top: 50),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Market ki\nmehngi\nqeematon\nse jaan \nchudwana\nchahte\nho?",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontSize: 49,
                      height: 0.9,
                      // fontWeight: FontWeight.bold,
                      // color: MyColors.primaryColor,
                      color: MyColors.secondaryColor,
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
                    "  Yes  ",
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OnboardScreen2()),
                      );
                    },
                    colorInvert: true,
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
