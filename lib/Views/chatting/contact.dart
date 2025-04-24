import 'package:agriconnect/Views/chatting/chatScrren.dart';
import 'package:agriconnect/Views/chatting/registerScreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ContactsScreen extends StatefulWidget {
  final String phone;
  ContactsScreen({required this.phone});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final DatabaseReference dbRef = FirebaseDatabase.instance.ref();

  // ✅ Logout Function
  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => RegisterScreen()),
    );
  }

  // ✅ Add Contact Dialog
  Future<void> showAddContactDialog() async {
    TextEditingController phoneController = TextEditingController();
    TextEditingController nameController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Contact'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                String contactPhone = phoneController.text.trim();
                String contactName = nameController.text.trim();

                // 🔍 Check if user exists
                DataSnapshot snapshot = await dbRef.child('users').child(contactPhone).get();
                if (snapshot.exists) {
                  // ✅ Save contact under current user
                  await dbRef
                      .child('contacts')
                      .child(widget.phone)
                      .child(contactPhone)
                      .set({
                    'name': contactName,
                    'phone': contactPhone,
                  });
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('User not found')),
                  );
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => logout(context),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: showAddContactDialog,
        child: Icon(Icons.person_add),
      ),
      body: StreamBuilder(
        stream: dbRef.child('contacts').child(widget.phone).onValue,
        builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
          if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
            return Center(
              child: Text("No contacts found.\nTap '+' to add one.", textAlign: TextAlign.center),
            );
          }

          Map<dynamic, dynamic> contactsMap =
              snapshot.data!.snapshot.value as Map<dynamic, dynamic>;

          List<Map<String, dynamic>> contacts = contactsMap.entries.map((entry) {
            return {
              'phone': entry.value['phone'],
              'name': entry.value['name'],
            };
          }).toList();

          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final contact = contacts[index];

              return Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.green.shade700,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  title: Text(
                    contact['name']!,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(contact['phone']!),
                  trailing: Icon(Icons.chat, color: Colors.green),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          sender: widget.phone,
                          receiver: contact['phone']!,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
