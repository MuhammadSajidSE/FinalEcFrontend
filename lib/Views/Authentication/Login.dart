import 'package:agriconnect/Component/customButton.dart';
import 'package:agriconnect/Component/customSize.dart';
import 'package:agriconnect/Component/elevatedBtn.dart';
import 'package:agriconnect/Component/inputField.dart';
import 'package:agriconnect/Controllers/LoginController.dart';
import 'package:agriconnect/Views/Authentication/signUp.dart';
import 'package:agriconnect/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:agriconnect/Views/Authentication/BuyerSignUp.dart';
import 'package:agriconnect/Views/Authentication/FarmerSignUp.dart';
import 'package:agriconnect/Views/Authentication/TrainerSignUp.dart';
import 'package:agriconnect/Views/Authentication/TransporterSignUp.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatelessWidget {
  final LoginController _controller = LoginController();

  Login({Key? key}) : super(key: key);

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
            Container(
              height: 100,
              width: double.infinity,
              color: MyColors.primaryColor,
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Login',
                  style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: MyColors.primaryColor),
                ),
                // Text(
                //   "Login",
                //   style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900,color: MyColors.primaryColor),
                // ),
        
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => signUpScreen()));
                  },
                  child: Text(
                    'Register',
                    style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: MyColors.black),
                  ),
                ),
        
                //      Text(
                //   "Register",
                //   style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900,color: MyColors.black),
                // ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
        
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              height: 3.5,
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: Container(color: MyColors.primaryColor), // 50% Green
                  ),
                  Expanded(
                    child: Container(color: Colors.grey.shade300), // 50% Grey
                  ),
                ],
              ),
            ),
        
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome to',
                  style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: MyColors.black),
                ),
                // Text(
                //   "Welcome to ",
                //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900,color: Colors.black),
                // ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  'AgriConnect',
                  style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: MyColors.primaryColor),
                ),
                // Text(
                //   "AgriConnect",
                //   style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900,color: MyColors.primaryColor),
                // ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: MyTextField(emailController,
                  hintText: "Enter your email",
                  prefixIcon: Icons.email,
                  keyboardType: TextInputType.emailAddress),
            ),
            // TextField(
            //   controller: emailController,
            //   decoration: const InputDecoration(
            //     labelText: 'Email',
            //     border: OutlineInputBorder(),
            //     prefixIcon: Icon(Icons.email),
            //   ),
            //   keyboardType: TextInputType.emailAddress,
            // ),
            const SizedBox(height: 16),
            // TextField(
            //   controller: passwordController,
            //   decoration: const InputDecoration(
            //     labelText: 'Password',
            //     border: OutlineInputBorder(),
            //     prefixIcon: Icon(Icons.lock),
            //   ),
            //   obscureText: true,
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: MyTextField(
                passwordController,
                hintText: "Enter your password",
                prefixIcon: Icons.lock,
                isPassword: true, // Hide password
              ),
            ),
            const SizedBox(height: 24),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: CustomButton(
                radius: CustomSize().customWidth(context) / 10,
                height: CustomSize().customHeight(context) / 15,
                width: CustomSize().customWidth(context),
                title: "Login",
                loading: false,
                color: MyColors.primaryColor,
                onTap: () async {
                  await _controller.login(
                    context: context,
                    email: emailController.text,
                    password: passwordController.text,
                  );
                },
              ),
            ),
            // MyElevatedBtn("Login", () async {
            //   await _controller.login(
            //     context: context,
            //     email: emailController.text,
            //     password: passwordController.text,
            //   );
            // }),
            const SizedBox(height: 4),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 15),
                  child: Text(
                    "Forgot Password?",
                    style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: MyColors.primaryColor),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an Account?",
                  style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: MyColors.black),
                ),
                SizedBox(
                  width: 4,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => signUpScreen()));
                  },
                  child: Text(
                    "Sign Up",
                    style: GoogleFonts.inter(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: MyColors.primaryColor),
                  ),
                ),
        // Text("Don't have an Account?"),
                // MyTextButton("Sign Up", ()=> _showSignUpDialog(context))
              ],
            )
          ],
        ),
      ),
      // ),
    );
  }

  // void _showSignUpDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Select User Type'),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             _buildSignUpButton(context, 'Farmer', FarmerSignup()),
  //             _buildSignUpButton(context, 'Buyer',  BuyerSignup()),
  //             _buildSignUpButton(
  //                 context, 'Transporter', TransporterSignup()),
  //             _buildSignUpButton(context, 'Trainer', TrainerSignup()),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
  void _showSignUpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Select User Type',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.grey),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSignUpOption(
                  context, 'Farmer', Icons.agriculture, FarmerSignup()),
              _buildSignUpOption(
                  context, 'Buyer', Icons.shopping_cart, BuyerSignup()),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSignUpOption(
      BuildContext context, String role, IconData icon, Widget page) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: MyElevatedBtn(
        role,
        () {
          Navigator.pop(context); // Close the dialog before navigation
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => page));
        },
      ),
    );
  }

  Widget _buildSignUpButton(BuildContext context, String role, Widget page) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context); // Close the popup
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Text(role),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:agriconnect/Components/elevatedBtn.dart';
// import 'package:agriconnect/Components/inputField.dart';
// import 'package:agriconnect/Controllers/LoginController.dart';
// import 'package:agriconnect/constants/colors.dart';

// class Login extends StatefulWidget {
//   @override
//   _LoginState createState() => _LoginState();
// }

// class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   final LoginController _controller = LoginController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   bool rememberMe = false;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // Green Header
//             Container(
//               height: 140,
//               decoration: BoxDecoration(
//                 color: MyColors.primaryColor,
//                 borderRadius: const BorderRadius.only(
//                   bottomLeft: Radius.circular(25),
//                   bottomRight: Radius.circular(25),
//                 ),
//               ),
//               child: Center(
//                 child: Text(
//                   "Sign In",
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 10),

//             // TabBar for Login/Register
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: TabBar(
//                 controller: _tabController,
//                 indicatorColor: MyColors.primaryColor,
//                 labelColor: MyColors.primaryColor,
//                 unselectedLabelColor: Colors.grey,
//                 tabs: const [
//                   Tab(text: "Login"),
//                   Tab(text: "Register"),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 20),

//             // Login Form
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Sign In",
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   const Text("Karibu, Una akaunti?"),
//                   const SizedBox(height: 20),

//                   // Email Input
//                   MyTextField(
//                     emailController,
//                     hintText: "Username",
//                     prefixIcon: Icons.person,
//                     keyboardType: TextInputType.emailAddress,
//                   ),
//                   const SizedBox(height: 16),

//                   // Password Input
//                   MyTextField(
//                     passwordController,
//                     hintText: "Password",
//                     prefixIcon: Icons.lock,
//                     isPassword: true,
//                   ),
//                   const SizedBox(height: 10),

//                   // Remember Me & Forgot Password
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           Checkbox(
//                             value: rememberMe,
//                             activeColor: MyColors.primaryColor,
//                             onChanged: (value) {
//                               setState(() {
//                                 rememberMe = value!;
//                               });
//                             },
//                           ),
//                           const Text("Remember Me"),
//                         ],
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           // TODO: Navigate to Forgot Password
//                         },
//                         child: const Text(
//                           "Forgot password?",
//                           style: TextStyle(color: Colors.blue),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),

//                   // Login Button
//                   MyElevatedBtn(
//                     "Login",
//                     () async {
//                       await _controller.login(
//                         context: context,
//                         email: emailController.text,
//                         password: passwordController.text,
//                       );
//                     },
//                   ),

//                   const SizedBox(height: 20),

//                   // OR Divider
//                   Row(
//                     children: const [
//                       Expanded(child: Divider(thickness: 1)),
//                       Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 8),
//                         child: Text("AU"),
//                       ),
//                       Expanded(child: Divider(thickness: 1)),
//                     ],
//                   ),

//                   const SizedBox(height: 20),

//                   // Social Login Buttons
//                   _socialLoginButton("Ingiza kwa Google", "assets/google.png"),
//                   const SizedBox(height: 10),
//                   _socialLoginButton("Ingiza kwa Apple", "assets/apple.png"),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _socialLoginButton(String text, String imagePath) {
//     return ElevatedButton.icon(
//       onPressed: () {},
//       icon: Image.asset(imagePath, height: 20),
//       label: Text(text),
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         elevation: 1,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         minimumSize: const Size(double.infinity, 50),
//       ),
//     );
//   }
// }
