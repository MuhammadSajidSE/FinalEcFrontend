// import 'dart:convert';
// import 'package:agriconnect/Views/Authentication/Login.dart';
// import 'package:agriconnect/Views/Buyer/mainBuyer.dart';
// import 'package:agriconnect/Views/Farmer/mainFarmer.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class LoginController {
//   final String loginApiUrl = 'http://152.67.10.128:5280/api/auth/login';
//   // final String loginApiUrl = 'http://localhost:5280/api/auth/login';

//   final String getDataApiUrl =
//       'http://152.67.10.128:5280/api/auth/Get-Data-Token';
//   final String tokenKey = 'auth_token';

//   Future<void> login({
//     required BuildContext context,
//     required String email,
//     required String password,
//   }) async {
//     if (email.isEmpty || password.isEmpty) {
//       _showPopup(context, 'Please fill all fields');
//       return;
//     }

//     final headers = {'Content-Type': 'application/json'};
//     final body = jsonEncode({'email': email, 'password': password});

//     try {
//       final response = await http.post(
//         Uri.parse(loginApiUrl),
//         headers: headers,
//         body: body,
//       );

//       if (response.statusCode == 200 && response.body.isNotEmpty) {
//         final data = jsonDecode(response.body);
//         final token = data['token']?['result'] ?? '';

//         if (token.isNotEmpty) {
//           await _storeTokenAndFetchUserData(context, token);
//         } else {
//           _showPopup(context, 'Failed to retrieve token');
//         }
//       } else {
//         _showPopup(
//           context,
//           'Failed to login. Status Code: ${response.statusCode}',
//         );
//       }
//     } catch (e) {
//       _showPopup(context, 'An error occurred: $e');
//     }
//   }

//   Future<void> _storeTokenAndFetchUserData(
//       BuildContext context, String token) async {
//     final prefs = await SharedPreferences.getInstance();

//     // Store token
//     await prefs.setString(tokenKey, token);
//     print('Token stored successfully!');

//     // Retrieve stored token for verification
//     String? storedToken = prefs.getString(tokenKey);
//     print('Stored Token Key: $tokenKey'); // Debugging: Print key name
//     print(
//         'Retrieved Token from SharedPreferences: $storedToken'); // Debugging: Print stored token

//     if (storedToken == null || storedToken.isEmpty) {
//       print('Error: Token was not stored properly!');
//       return;
//     }

//     // Fetch user data using the stored token
//     await _fetchUserData(context, storedToken);
//   }

//   Future<void> _fetchUserData(BuildContext context, String token) async {
//     try {
//       final url = '$getDataApiUrl?token=${Uri.encodeComponent(token)}';
//       print('Requesting: $url');

//       final response = await http.get(Uri.parse(url));

//       if (response.statusCode == 200 && response.body.isNotEmpty) {
//         print('Response Data: ${response.body}');
//         final data = jsonDecode(response.body);

//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setString('imageUrl', data['imageUrl'] ?? '');
//         await prefs.setString('username', data['userName'] ?? '');
//         await prefs.setInt('userId', data['id'] ?? 0);
//         await prefs.setString('phoneno', data['phoneNumber'] ?? '');
//         await prefs.setString('roleName', data['role']?['name'] ?? '');
//         await prefs.setString('roleId', data['\$id'] ?? 0);

//         // Retrieve and print stored values from SharedPreferences
//         print('Stored SharedPreferences Data:');
//         print('imageUrl: ${prefs.getString('imageUrl')}');
//         print('username: ${prefs.getString('username')}');
//         print('userId: ${prefs.getInt('userId')}');
//         print('roleName: ${prefs.getString('roleName')}');
//         print('roleId: ${prefs.getString('roleId')}');

//         // Check if the user is active
//         final bool isActive = data['isactive'] ?? false;

//         if (!isActive) {
//           _showPopup(
//               context, 'Your account is deactivated. Please contact support.');
//           return;
//         }

//         // Navigate to the related screen based on role
//         final roleName = prefs.getString('roleName') ?? '';

//         switch (roleName) {
//           case 'Buyer':
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => BuyerMain()),
//             );
//             break;
//           case 'Farmer':
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => FarmerMain()),
//             );
//             break;
//           default:
//             _showPopup(context, 'Unknown user role: $roleName');
//         }
//       } else {
//         print('Error Response: ${response.statusCode} - ${response.body}');
//         _showPopup(
//           context,
//           'Failed to fetch user data. Status Code: ${response.statusCode}',
//         );
//       }
//     } catch (e) {
//       print('Exception: $e');
//       _showPopup(context, 'An error occurred: $e');
//     }
//   }

//   Future<void> _showPopup(BuildContext context, String message) async {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Notification'),
//           content: Text(message),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   final String getDataApiUrlToken =
//       'http://152.67.10.128:5280/api/auth/Get-Data-Token';

//   Future<void> checkLoginStatus(BuildContext context) async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('auth_token');

//     if (token != null && token.isNotEmpty) {
//       await _fetchUserDatatoken(context, token);
//     } else {
//       _navigateToLogin(context);
//     }
//   }

//   Future<void> _fetchUserDatatoken(BuildContext context, String token) async {
//     try {
//       final response = await http.get(
//         Uri.parse('$getDataApiUrlToken?token=${Uri.encodeComponent(token)}'),
//       );

//       if (response.statusCode == 200 && response.body.isNotEmpty) {
//         final data = jsonDecode(response.body);
//         final roleName = data['role']?['name'] ?? '';

//         switch (roleName) {
//           case 'Buyer':
//             _navigateToScreen(context, BuyerMain());
//             break;
//           case 'Farmer':
//             _navigateToScreen(context, FarmerMain());
//             break;
//           default:
//             _navigateToLogin(context);
//         }
//       } else {
//         _navigateToLogin(context);
//       }
//     } catch (e) {
//       print('Error fetching user data: $e');
//       _navigateToLogin(context);
//     }
//   }

//   void _navigateToLogin(BuildContext context) {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => Login()),
//     );
//   }

//   void _navigateToScreen(BuildContext context, Widget screen) {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => screen),
//     );
//   }

//   Future<void> logout(BuildContext context) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.clear(); // Remove all stored data

//     // Navigate to the login screen
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (context) => Login()),
//       (route) => false, // Remove all previous routes
//     );
//   }
// }

import 'dart:convert';
import 'package:agriconnect/Views/Authentication/Login.dart';
import 'package:agriconnect/Views/Buyer/mainBuyer.dart';
import 'package:agriconnect/Views/Farmer/mainFarmer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  final String loginApiUrl = 'http://152.67.10.128:5280/api/auth/login';
  // final String loginApiUrl = 'http://localhost:5280/api/auth/login';

  final String getDataApiUrl =
      'http://152.67.10.128:5280/api/auth/Get-Data-Token';
  final String tokenKey = 'auth_token';

  Future<void> login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      _showPopup(context, 'Please fill all fields');
      return;
    }

    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'email': email, 'password': password});

    try {
      final response = await http.post(
        Uri.parse(loginApiUrl),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final data = jsonDecode(response.body);
        final token = data['token']?['result'] ?? '';

        if (token.isNotEmpty) {
          await _storeTokenAndFetchUserData(context, token);
        } else {
          _showPopup(context, 'Failed to retrieve token');
        }
      } else {
        _showPopup(
          context,
          'Failed to login. Status Code: ${response.statusCode}',
        );
      }
    } catch (e) {
      _showPopup(context, 'An error occurred: $e');
    }
  }

  Future<void> _storeTokenAndFetchUserData(
      BuildContext context, String token) async {
    final prefs = await SharedPreferences.getInstance();

    // Store token
    await prefs.setString(tokenKey, token);
    print('Token stored successfully!');

    // Retrieve stored token for verification
    String? storedToken = prefs.getString(tokenKey);
    print('Stored Token Key: $tokenKey'); // Debugging: Print key name
    print(
        'Retrieved Token from SharedPreferences: $storedToken'); // Debugging: Print stored token

    if (storedToken == null || storedToken.isEmpty) {
      print('Error: Token was not stored properly!');
      return;
    }

    // Fetch user data using the stored token
    await _fetchUserData(context, storedToken);
  }

  Future<void> _fetchUserData(BuildContext context, String token) async {
    try {
      final url = '$getDataApiUrl?token=${Uri.encodeComponent(token)}';
      print('Requesting: $url');

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        print('Response Data: ${response.body}');
        final data = jsonDecode(response.body);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('imageUrl', data['imageUrl'] ?? '');
        await prefs.setString('username', data['userName'] ?? '');
        await prefs.setInt('userId', data['id'] ?? 0);
        await prefs.setString('phoneno', data['phoneNumber'] ?? '');
        await prefs.setString('roleName', data['role']?['name'] ?? '');
        await prefs.setString('roleId', data['\$id'] ?? 0);

        // Retrieve and print stored values from SharedPreferences
        print('Stored SharedPreferences Data:');
        print('imageUrl: ${prefs.getString('imageUrl')}');
        print('username: ${prefs.getString('username')}');
        print('userId: ${prefs.getInt('userId')}');
        print('roleName: ${prefs.getString('roleName')}');
        print('roleId: ${prefs.getString('roleId')}');

        // Check if the user is active
        final bool isActive = data['isactive'] ?? false;

        if (!isActive) {
          _showPopup(
              context, 'Your account is deactivated. Please contact support.');
          return;
        }

        // Navigate to the related screen based on role
        final roleName = prefs.getString('roleName') ?? '';

        switch (roleName) {
          case 'Buyer':
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => BuyerMain()),
            );
            break;
          case 'Farmer':
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => FarmerMain()),
            );
            break;
          default:
            _showPopup(context, 'Unknown user role: $roleName');
        }
      } else {
        print('Error Response: ${response.statusCode} - ${response.body}');
        _showPopup(
          context,
          'Failed to fetch user data. Status Code: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Exception: $e');
      _showPopup(context, 'An error occurred: $e');
    }
  }

  Future<void> _showPopup(BuildContext context, String message) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Notification'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  final String getDataApiUrlToken =
      'http://152.67.10.128:5280/api/auth/Get-Data-Token';

  Future<void> checkLoginStatus(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token != null && token.isNotEmpty) {
      await _fetchUserDatatoken(context, token);
    } else {
      _navigateToLogin(context);
    }
  }

  Future<void> _fetchUserDatatoken(BuildContext context, String token) async {
    try {
      final response = await http.get(
        Uri.parse('$getDataApiUrlToken?token=${Uri.encodeComponent(token)}'),
      );

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final data = jsonDecode(response.body);
        final roleName = data['role']?['name'] ?? '';

        switch (roleName) {
          case 'Buyer':
            _navigateToScreen(context, BuyerMain());
            break;
          case 'Farmer':
            _navigateToScreen(context, FarmerMain());
            break;
          default:
            _navigateToLogin(context);
        }
      } else {
        _navigateToLogin(context);
      }
    } catch (e) {
      print('Error fetching user data: $e');
      _navigateToLogin(context);
    }
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  void _navigateToScreen(BuildContext context, Widget screen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Remove all stored data

    // Navigate to the login screen
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Login()),
      (route) => false, // Remove all previous routes
    );
  }
}
