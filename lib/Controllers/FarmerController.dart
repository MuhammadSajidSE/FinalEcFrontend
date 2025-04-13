import 'dart:convert';
import 'dart:io';
import 'package:agriconnect/Views/Authentication/Login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Farmercontroller {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController nicController = TextEditingController();

  File? image;

  /// Pick image from gallery
  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
  }

  /// Show popup message
  void showPopup(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Message'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  /// Register buyer function
  Future<void> register(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      showPopup(context, 'Please fill all required fields.');
      return;
    }

    if (image == null) {
      showPopup(context, 'Please select an image.');
      return;
    }

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://152.67.10.128:5280/api/farmer/register'),
    );

    request.fields['UserName'] = userNameController.text;
    request.fields['Email'] = emailController.text;
    request.fields['Password'] = passwordController.text;
    request.fields['PhoneNumber'] = phoneNumberController.text;
    request.fields['Address'] = addressController.text;
    request.fields['Role'] = 'Farmer'; // Default role
    request.fields['NIC'] = nicController.text;

    request.files.add(await http.MultipartFile.fromPath('File', image!.path));

    try {
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

if (response.statusCode == 200) {
    showPopup(context, 'Registration successful!');
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  Login()),
    );
} else {
    var message = jsonDecode(responseBody)['message'] ?? 'Registration failed.';
    showPopup(context, message);
}

    } catch (e) {
      showPopup(context, 'Error: $e');
    }
  }

  Future<Map<String, dynamic>> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'imageUrl': prefs.getString('imageUrl'),
      'username': prefs.getString('username'),
      'userId': prefs.getInt('userId')?.toString(),
      'roleName': prefs.getString('roleName'),
      'roleId': prefs.getString('roleId'),
    };
  }
  /// Dispose controllers
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    nicController.dispose();
  }
}
