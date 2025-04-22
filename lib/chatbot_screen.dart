import 'dart:convert';
import 'package:agriconnect/Controllers/FarmerController.dart';
import 'package:agriconnect/Views/Farmer/mainFarmer.dart';
import 'package:agriconnect/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});
  

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
   
   String? imageUrl;
   final Farmercontroller myController = Farmercontroller();

   @override
  void initState() {
     _loadUserData();
    
  }

  
  Future<void> _loadUserData() async {
    final userData = await myController.loadUserData();
    setState(() {
      imageUrl = userData['imageUrl'];

    });
  }

  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<Map<String, String>> _messages = []; // role: user/bot, text: msg, time: hh:mm

  bool isLoading = false;
  final String apiKey = "AIzaSyAmhkluVKLRJnsKE1J6suX9ZGAYYnbhzio";

  Future<String> _sendMessageToApi(String message) async {
    setState(() {
      isLoading = true;
    });

    final response = await http.post(
      Uri.parse('https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$apiKey'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "contents": [
          {
            "role": "user",
            "parts": [{"text": message}]
          }
        ]
      }),
    );

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData["candidates"][0]["content"]["parts"][0]["text"].toString();
    } else {
      return "Error: Failed to get response.";
    }
  }

  void _sendMessage() async {
    String userInput = _controller.text.trim();
    if (userInput.isEmpty) return;

    String timeNow = _formatTime(DateTime.now());

    setState(() {
      _messages.add({"role": "user", "text": userInput, "time": timeNow});
      _controller.clear();
    });
    _scrollToBottom();

    String botResponse = await _sendMessageToApi(userInput);
    timeNow = _formatTime(DateTime.now());
    setState(() {
      _messages.add({"role": "bot", "text": botResponse, "time": timeNow});
    });

    _scrollToBottom();
  }

  String _formatTime(DateTime dt) {
    return "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 100,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Widget _buildMessageBubble(Map<String, String> msg,String imageUrl) {
    final bool isUser = msg["role"] == "user";
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!isUser)
                 CircleAvatar(
                  backgroundColor: MyColors.primaryColor,
                  // radius: 22,
                  backgroundImage: AssetImage('assets/bot_avatar.png'),
                ),
              const SizedBox(width: 8),
              Flexible(
                child: Container(
                  padding:  EdgeInsets.all(12),
                  margin:  EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                   color: isUser ? Color(0xFFDEE2E6) : MyColors.primaryColor,
                     borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    msg["text"] ?? '',
                    style:  GoogleFonts.inter(
                      color: isUser ? Colors.black : Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              if (isUser)
                CircleAvatar(
              backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
              child: imageUrl == null ? const Icon(Icons.person) : null,
            ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 4, left: 4, right: 4),
            child: Row(
              mainAxisAlignment:
                  isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                Text(
                  msg["time"] ?? '',
                  style:  GoogleFonts.inter(fontSize: 12, color: Colors.grey),
                ),
                if (isUser) ...[
                  const SizedBox(width: 4),
                   Icon(Icons.done_all, size: 16, color: MyColors.primaryColor),
                ]
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
       appBar: AppBar(

         backgroundColor: MyColors.primaryColor,
        automaticallyImplyLeading: false,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(15),
      bottomRight: Radius.circular(15),
    ),
  ),
  elevation: 3,
  leading: InkWell(
    onTap: (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>FarmerMain()));
                       
    },
    child: Container(
      margin: const EdgeInsets.all(5),
      child: Image.asset("assets/bot_avatar.png"),
    ),
  ),
  title: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
           Text(
              "ChatBot",
              style: GoogleFonts.inter(
                fontSize: 19,
                fontWeight: FontWeight.w600,
                color: MyColors.backgroundScaffoldColor,
              ),
            ),
         
        ],
      ),
      const SizedBox(height: 2),
      Row(
        children: [
           CircleAvatar(
            radius: 3,
            backgroundColor: MyColors.backgroundScaffoldColor,
          ),
          const SizedBox(width: 5),
           Text(
              "Online",
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: MyColors.backgroundScaffoldColor,
              ),
            ),
          
        ],
      )
    ],
  ),
),

  
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, index) {
                return _buildMessageBubble(_messages[index], imageUrl ?? '');
              },
            ),
          ),
          if (isLoading)
             Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(
                backgroundColor: MyColors.primaryColor,
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                         style: const TextStyle(fontSize: 16),
                     cursorColor:  MyColors.primaryColor,
                    controller: _controller,
                    
                    decoration: InputDecoration(
                      contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      hintText: "Type your message here...",
                        filled: true,
          fillColor: Color(0xFFDEE2E6),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12), 
            borderSide: BorderSide(color: MyColors.primaryColor, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: MyColors.grey, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: MyColors.primaryColor, width: 2),
          ),
        
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                  color: MyColors.primaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
