import 'dart:convert';
import 'package:agriconnect/Views/Buyer/mainBuyer.dart';
import 'package:agriconnect/Views/Farmer/mainFarmer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<Map<String, dynamic>> fetchUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';

    final url =
        'http://152.67.10.128:5280/api/auth/Get-Data-Token?token=$token';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load profile data.");
    }
  }

  Future<void> _navigateBack(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
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
        Navigator.pop(context); // Go back to the previous screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await _navigateBack(context);
        return false; // Prevent default back behavior
      },
      child: Scaffold(
        body: FutureBuilder<Map<String, dynamic>>(
          future: fetchUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else if (!snapshot.hasData) {
              return const Center(child: Text("No Data Available"));
            }

            final userData = snapshot.data!;
            final imageUrl = userData['imageUrl'] ?? '';
            final username = userData['userName'] ?? 'Unknown';
            final email = userData['email'] ?? 'No Email';
            final phoneNumber = userData['phoneNumber'] ?? 'No Phone';
            final address = userData['address'] ?? 'No Address';
            final roleName = userData['role']?['name'] ?? 'No Role';
            final isActive = userData['isactive'] ?? false;

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey.shade300,
                    backgroundImage: imageUrl.isNotEmpty
                        ? NetworkImage(imageUrl)
                        : AssetImage('assets/default_avatar.png')
                            as ImageProvider,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    username,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    roleName,
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                  ),
                  const SizedBox(height: 10),
                  Chip(
                    label: Text(
                      isActive ? "Active" : "Deactivated",
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: isActive ? Colors.green : Colors.red,
                  ),
                  const SizedBox(height: 20),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 3,
                    child: ListTile(
                      leading: const Icon(Icons.email, color: Colors.blue),
                      title: Text(email),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 3,
                    child: ListTile(
                      leading: const Icon(Icons.phone, color: Colors.green),
                      title: Text(phoneNumber),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 3,
                    child: ListTile(
                      leading: const Icon(Icons.location_on, color: Colors.red),
                      title: Text(address),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
