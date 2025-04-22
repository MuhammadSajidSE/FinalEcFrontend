import 'package:agriconnect/Views/Order/cancelPayment.dart';
import 'package:agriconnect/Views/Order/confirmPayment.dart';
import 'package:agriconnect/Views/StartScreen/SplashScree.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'firebase_options.dart';  // Import the generated firebase_options.dart
// import 'package:agriconnect/Views/Order/confirmPayment.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,  // Use the generated options
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'AgriConnect',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),  // Your splash screen
      // home: OrderCancellationScreen(),  // Your splash screen
      debugShowCheckedModeBanner: false,
    );
  }
}

