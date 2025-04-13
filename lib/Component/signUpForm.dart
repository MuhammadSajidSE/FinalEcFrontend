// import 'package:flutter/material.dart';

// class SignupForm extends StatefulWidget {
//   final dynamic controller;
//   final String title;
//   final String role;

//   const SignupForm({
//     Key? key,
//     required this.controller,
//     required this.title,
//     required this.role,
//   }) : super(key: key);

//   @override
//   _SignupFormState createState() => _SignupFormState();
// }

// class _SignupFormState extends State<SignupForm> {
//   @override
//   void dispose() {
//     widget.controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.title)),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: widget.controller.formKey,
//           child: Column(
//             children: [
//               _buildTextField(widget.controller.userNameController, 'Username'),
//               _buildTextField(widget.controller.emailController, 'Email',
//                   inputType: TextInputType.emailAddress),
//               _buildTextField(widget.controller.passwordController, 'Password',
//                   obscureText: true),
//               _buildTextField(widget.controller.phoneNumberController, 'Phone Number',
//                   inputType: TextInputType.phone),
//               _buildTextField(widget.controller.addressController, 'Address'),
//               _buildTextField(widget.controller.nicController, 'NIC'),

//               // Extra field for Trainers
//               if (widget.role == "Trainer")
//                 _buildTextField(widget.controller.experienceController, 'Experience'),

//               const SizedBox(height: 10),
//               widget.controller.image != null
//                   ? Image.file(widget.controller.image!, height: 100)
//                   : const Text('No image selected'),
//               ElevatedButton(
//                 onPressed: () async {
//                   await widget.controller.pickImage();
//                   setState(() {});
//                 },
//                 child: const Text('Pick Image'),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () => widget.controller.register(context),
//                 child: Text('Register as ${widget.role}'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(TextEditingController controller, String label,
//       {bool obscureText = false, TextInputType inputType = TextInputType.text}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: TextFormField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: label,
//           border: OutlineInputBorder(),
//         ),
//         obscureText: obscureText,
//         keyboardType: inputType,
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return '$label is required';
//           }
//           return null;
//         },
//       ),
//     );
//   }
// }

import 'package:agriconnect/Component/customButton.dart';
import 'package:agriconnect/Component/customSize.dart';
import 'package:agriconnect/Component/inputField.dart';
import 'package:agriconnect/Views/Authentication/Login.dart';
import 'package:agriconnect/Views/Authentication/signUp.dart';
import 'package:agriconnect/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupForm extends StatefulWidget {
  final dynamic controller;
  final String title;
  final String role;

  const SignupForm({
    Key? key,
    required this.controller,
    required this.title,
    required this.role,
  }) : super(key: key);

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundScaffoldColor,
      // appBar: AppBar(title: Text(widget.title)),
      body: SingleChildScrollView(
        // padding: const EdgeInsets.all(16.0),
        child: Form(
          key: widget.controller.formKey,
          child: Column(
            children: [
             Container(height: 100,width: double.infinity,color: MyColors.primaryColor,
           child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
             children: [
               IconButton(onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>signUpScreen()));
                       
               }, icon: Icon(Icons.arrow_back_ios,color: MyColors.backgroundScaffoldColor,)),
             ],
           ),),
           SizedBox(
                height: 10,
              ),
                  Text(
                        widget.title,
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: MyColors.primaryColor
                        ),
                      ),

              SizedBox(
                height: 10,
              ),
              MyTextField(widget.controller.userNameController,
                  hintText: 'Username', prefixIcon: Icons.person),
              const SizedBox(height: 10),
              MyTextField(widget.controller.emailController,
                  hintText: 'Email',
                  prefixIcon: Icons.email,
                  keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 10),
              MyTextField(widget.controller.passwordController,
                  hintText: 'Password',
                  prefixIcon: Icons.lock,
                  isPassword: true),
              const SizedBox(height: 10),
              MyTextField(widget.controller.phoneNumberController,
                  hintText: 'Phone Number',
                  prefixIcon: Icons.phone,
                  keyboardType: TextInputType.phone),
              const SizedBox(height: 10),
              MyTextField(widget.controller.addressController,
                  hintText: 'Address', prefixIcon: Icons.location_on),
              const SizedBox(height: 10),
              MyTextField(widget.controller.nicController,
                  hintText: 'NIC', prefixIcon: Icons.credit_card),

              // Extra field for Trainers
              if (widget.role == "Trainer")
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: MyTextField(widget.controller.experienceController,
                      hintText: 'Experience', prefixIcon: Icons.work),
                ),

              const SizedBox(height: 5),
              widget.controller.image != null
                  ? Image.file(widget.controller.image!, height: 100)
                  : 

                  Text(
                          'No image selected',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromARGB(255, 11, 9, 9)
                          ),
                        ),
              const SizedBox(height: 5),
                 Container(
            margin: EdgeInsets.only(left: 15,right: 15),
            child:    CustomButton(
                          radius: CustomSize().customWidth(context) / 10,
                          height: CustomSize().customHeight(context) / 15,
                          width: CustomSize().customWidth(context) ,
                          title: "Pick Image",
                          
                          loading: false,
                          color: MyColors.primaryColor,
                          onTap: () async {
                await widget.controller.pickImage();
                setState(() {});
              }
                        ),
           ),
              // MyElevatedBtn("Pick Image", () async {
              //   await widget.controller.pickImage();
              //   setState(() {});
              // }),

              const SizedBox(height: 10),
               Container(
            margin: EdgeInsets.only(left: 15,right: 15),
            child:    CustomButton(
                          radius: CustomSize().customWidth(context) / 10,
                          height: CustomSize().customHeight(context) / 15,
                          width: CustomSize().customWidth(context) ,
                          title: "Register as ${widget.role}",
                          
                          loading: false,
                          color: MyColors.primaryColor,
                          onTap: () => widget.controller.register(context)
                        ),
           ),
              // MyElevatedBtn("Register as ${widget.role}",
              //     () => widget.controller.register(context)),

                         const SizedBox(height: 10),

 Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text(
                      "Already have an Account?",
                      style: GoogleFonts.inter(
                        fontSize:16,
                        fontWeight: FontWeight.w600,
                        color: MyColors.black
                      ),
                    ),
                    SizedBox(width: 4,),
                     GestureDetector(
                      onTap: (){
                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
                       
                      },
                       child: Text(
                        "Login",
                        style: GoogleFonts.inter(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: MyColors.primaryColor
                        ),
                                           ),
                     ),
// Text("Don't have an Account?"),
            // MyTextButton("Sign Up", ()=> _showSignUpDialog(context))
  ],
 ),
 const SizedBox(height: 16),
          
            ],
          ),
        ),
      ),
    );
  }
}