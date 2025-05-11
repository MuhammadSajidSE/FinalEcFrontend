// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:http/http.dart' as http;
// import 'package:firebase_messaging/firebase_messaging.dart';

// class ChatScreen extends StatefulWidget {
//   final String sender;
//   final String receiver;

//   ChatScreen({required this.sender, required this.receiver});

//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _messageController = TextEditingController();
//   final DatabaseReference _dbRef = FirebaseDatabase.instance.ref().child("chats");

// @override
// void initState() {
//   super.initState();
//   FirebaseMessaging.instance.requestPermission();

//   FirebaseMessaging.instance.getToken().then((token) {
//     if (token != null) {
//       storeUserToken(widget.sender, token); // Store token for the logged-in user
//     }
//   });
// }



//   void sendMessage() async {
//     if (_messageController.text.trim().isEmpty) return;

//     String messageText = _messageController.text.trim();
//     String timestamp = DateTime.now().millisecondsSinceEpoch.toString();

//     Map<String, String> messageData = {
//       "text": messageText,
//       "timestamp": timestamp,
//       "sender": widget.sender,
//     };

//     _dbRef.child("${widget.sender}/${widget.receiver}/$timestamp").set(messageData);
//     _dbRef.child("${widget.receiver}/${widget.sender}/$timestamp").set(messageData);

//     bool notificationSent = await sendPushNotification(widget.receiver, messageText);
//     if (notificationSent) {
//       print("Notification sent successfully");
//     } else {
//       print("Failed to send notification");
//     }

//     _messageController.clear();
//   }

//   Future<bool> sendPushNotification(String receiver, String message) async {
//   String? receiverToken = await getUserToken(receiver);
//   if (receiverToken == null) {
//     print("Receiver token not found");
//     return false;
//   }

//   var notificationData = {
//     "to": receiverToken,
//     "notification": {
//       "title": "New Message from ${widget.sender}",
//       "body": message,
//     },
//     "data": {
//       "click_action": "FLUTTER_NOTIFICATION_CLICK",
//       "sender": widget.sender,
//     }
//   };

//   try {
//     var response = await http.post(
//       Uri.parse("https://fcm.googleapis.com/fcm/send"),  // Correct URL
//       headers: {
//         "Content-Type": "application/json",
//         "Authorization": "key=YOUR_SERVER_KEY",  // Replace with actual key
//       },
//       body: jsonEncode(notificationData),
//     );

//     if (response.statusCode == 200) {
//       print("Notification sent successfully");
//       return true;
//     } else {
//       print("FCM error: ${response.body}");
//       return false;
//     }
//   } catch (e) {
//     print("Error sending notification: $e");
//     return false;
//   }
// }

// Future<String?> getUserToken(String userId) async {
//   DatabaseReference tokenRef = FirebaseDatabase.instance.ref().child("users/$userId/token");
//   DatabaseEvent event = await tokenRef.once();

//   if (event.snapshot.value != null) {
//     print("Fetched token for user $userId: ${event.snapshot.value}");
//     return event.snapshot.value.toString();
//   } else {
//     print("No token found for user: $userId");
//     return null;
//   }
// }



// void storeUserToken(String userId, String token) {
//   DatabaseReference userRef = FirebaseDatabase.instance.ref().child("users/$userId");
//   userRef.update({"token": token}).then((_) {
//     print("Stored FCM Token for $userId: $token");
//   }).catchError((error) {
//     print("Error storing FCM token: $error");
//   });
// }



//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Chat with ${widget.receiver}"),
//         backgroundColor: Colors.green,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder(
//               stream: _dbRef.child("${widget.sender}/${widget.receiver}").onValue,
//               builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
//                 if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
//                   return Center(child: Text("No messages yet"));
//                 }

//                 Map<dynamic, dynamic> messagesMap =
//                     (snapshot.data!.snapshot.value as Map<dynamic, dynamic>) ?? {};
//                 List<MapEntry<dynamic, dynamic>> messagesList =
//                     messagesMap.entries.toList();
//                 messagesList.sort((a, b) => a.key.compareTo(b.key));

//                 return ListView.builder(
//                   itemCount: messagesList.length,
//                   itemBuilder: (context, index) {
//                     var message = messagesList[index].value;
//                     bool isMe = widget.sender == message["sender"];

//                     return Align(
//                       alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
//                       child: Container(
//                         margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                         padding: EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           color: isMe ? Colors.green.shade200 : Colors.blue.shade300,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               message["text"] ?? "No message",
//                               style: TextStyle(fontSize: 16),
//                             ),
//                             SizedBox(height: 4),
//                             Text(
//                               _formatTimestamp(message["timestamp"] ?? "0"),
//                               style: TextStyle(fontSize: 12, color: Colors.black54),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _messageController,
//                     decoration: InputDecoration(
//                       hintText: "Type a message...",
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send, color: Colors.green),
//                   onPressed: sendMessage,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   String _formatTimestamp(String timestamp) {
//     DateTime date = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp));
//     return "${date.hour}:${date.minute}";
//   }
// }
