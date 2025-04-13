import 'package:agriconnect/Component/customButton.dart';
import 'package:agriconnect/Component/customSize.dart';
import 'package:agriconnect/Controllers/LoginController.dart';
import 'package:agriconnect/Views/Authentication/Login.dart';
import 'package:agriconnect/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:agriconnect/Views/Authentication/BuyerSignUp.dart';
import 'package:agriconnect/Views/Authentication/FarmerSignUp.dart';
import 'package:agriconnect/Views/Authentication/TrainerSignUp.dart';
import 'package:agriconnect/Views/Authentication/TransporterSignUp.dart';
import 'package:google_fonts/google_fonts.dart';

class signUpScreen extends StatelessWidget {
  final LoginController _controller = LoginController();

  signUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: MyColors.backgroundScaffoldColor,

      // body: Padding(
        // padding: const EdgeInsets.only(left:16.0,right: 16),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
             Container(height: 100,width: double.infinity,color: MyColors.primaryColor,),
             SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                   GestureDetector(
                    onTap: (){
                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
                       
                    },
                     child: Text(
                          'Login',
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: MyColors.black
                          ),
                        ),
                   ),
                  // Text(
                  //   "Login",
                  //   style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900,color: MyColors.primaryColor),
                  // ),
          
                                      Text(
                        'Register',
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: MyColors.primaryColor
                        ),
                      ),
          
          
              //      Text(
              //   "Register",
              //   style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900,color: MyColors.black),
              // ),
                ],
              ),
           SizedBox(height: 10,),
          
           Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            height: 3.5,
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
          child: Container(color: Colors.grey.shade300), // 50% Green
                ),
                Expanded(
          child: Container(color: MyColors.primaryColor), // 50% Grey
                ),
              ],
            ),
          ),
          
          
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                       Text(
                        'Welcome to',
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: MyColors.black
                        ),
                      ),
              // Text(
              //   "Welcome to ",
              //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900,color: Colors.black),
              // ),
              SizedBox(width: 4,),
               Text(
                        'AgriConnect',
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: MyColors.primaryColor
                        ),
                      ),
              // Text(
              //   "AgriConnect",
              //   style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900,color: MyColors.primaryColor),
              // ),
                ],
              ),
              SizedBox(height: 30,),
             Stack(
            children: [
              // Background Image
              Image.asset(
                "assets/Rectangle 33.png",
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
          
              // Dark overlay
              Container(
                height: 300,
                width: double.infinity,
                color: Colors.black.withOpacity(0.4), // You can adjust the opacity
              ),
          
              // Text
              Container(
                margin: EdgeInsets.only(left: 15, top: 12),
                child: Text(
          "Taza aur\nsasti fasal\nseedha kisan\nse lo!", 
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily: 'Gilroy',
            fontSize: 49,
            height: 0.9,
            color: MyColors.secondaryColor,
          ),
                ),
              ),
            ],
          ),
          
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
                ),
                boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, -3),
          ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                 Container(
              margin: EdgeInsets.only(left: 15,right: 15),
              child:    CustomButton(
                            radius: CustomSize().customWidth(context) / 10,
                            height: CustomSize().customHeight(context) / 15,
                            width: CustomSize().customWidth(context) ,
                            title: "Farmer",
                            
                            loading: false,
                            color: MyColors.primaryColor,
                            onTap: () {
                                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>FarmerSignup()));
                       
                            },
                          ),
             ),
              SizedBox(height: 15,),
   
              Container(
              margin: EdgeInsets.only(left: 15,right: 15),
              child:    CustomButton(
                            radius: CustomSize().customWidth(context) / 10,
                            height: CustomSize().customHeight(context) / 15,
                            width: CustomSize().customWidth(context) ,
                            title: "Buyer",
                            
                            loading: false,
                            color: MyColors.primaryColor,
                            onTap: () {
                               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BuyerSignup()));
                       
                            },
                          ),
             ),
              SizedBox(height: 15,),
   
            //   Container(
            //   margin: EdgeInsets.only(left: 15,right: 15),
            //   child:    CustomButton(
            //                 radius: CustomSize().customWidth(context) / 10,
            //                 height: CustomSize().customHeight(context) / 15,
            //                 width: CustomSize().customWidth(context) ,
            //                 title: "Transporter",
                            
            //                 loading: false,
            //                 color: MyColors.primaryColor,
            //                 onTap: () {
            //                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TransporterSignup()));
                       
            //                 },
            //               ),
            //  ),
            //   SizedBox(height: 15,),
   
            //   Container(
            //   margin: EdgeInsets.only(left: 15,right: 15),
            //   child:    CustomButton(
            //                 radius: CustomSize().customWidth(context) / 10,
            //                 height: CustomSize().customHeight(context) / 15,
            //                 width: CustomSize().customWidth(context) ,
            //                 title: "Trainer",
                            
            //                 loading: false,
            //                 color: MyColors.primaryColor,
            //                 onTap: () {
            //                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TrainerSignup()));
            //                 },
            //               ),
            //  ),
                ],
              ),
            ),
          ),
          
          
            ],
          ),
        ),
      // ),
    );
  }
}