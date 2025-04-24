import 'package:agriconnect/Views/StartScreen/SplashScree.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';  // Import the generated firebase_options.dart

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
    return MaterialApp(
      title: 'AgriConnect',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),  // Your splash screen
      debugShowCheckedModeBanner: false,
    );
  }
}




// import 'package:agriconnect/Views/chatting/contact.dart';
// import 'package:agriconnect/Views/chatting/login.dart';
// import 'package:agriconnect/Views/chatting/registerScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:firebase_core/firebase_core.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//   runApp(MyApp());
// }

// // // Handle notification when the app is in the background
// // Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
// //   print("Notification Received: ${message.notification?.title}");
// // }

// class MyApp extends StatelessWidget {
//   Future<Widget> _getInitialScreen() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? phone = prefs.getString("phone");

//     if (phone != null && phone.isNotEmpty) {
//       return ContactsScreen(phone: phone);
//     } else {
//       return RegisterScreen();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: FutureBuilder<Widget>(
//         future: _getInitialScreen(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//           return snapshot.data ?? ChatLoginScreen();
//         },
//       ),
//     );
//   }
// }


